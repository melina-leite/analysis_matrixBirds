###############################################
#  Functions to calculate R2 of models terms  #
###############################################

# Melina Leite 
# Nov 2020

# Following Nakagawa & Schielzeth 2013, Johnson et al. 2014

# Auxiliary function to calculate R2s of each term in models
r2.calc <- function(model, coefs= c("forest_site400", "forest_land"), atrib="diet"){
  
  coefs = c("(Intercept)", coefs)
  
  # variance fixed effects
  var.f <- var(as.vector(fixef(model) %*% t(model@pp$X)))
  
  # variance sp random effect (intercept + slope)
  X <- model.matrix(model)
  n <- nrow(X)
  Z <- X[,coefs]
  sigma <- VarCorr(model)$sp
  
  var.sp <- sum(diag(Z %*% sigma %*% t(Z)))/n
  
  
  # variance (trait|site) and (trait|landscape)
  if(length(atrib)>1){
    trait <- c("(Intercept)")
    while(length(atrib)>0){
      cols1 <- grep(atrib[1], colnames(X), value=T)
      cols <- grep(":", cols1, value=T, invert = T)
      trait <- c(trait, cols)
      atrib <- atrib[-1]
    }
  }
  else{
    cols1 <- grep(atrib, colnames(X), value=T)
    cols <- grep(":", cols1, value=T, invert = T)
    trait <- c("(Intercept)", cols)
  }
  
  W <- X[,trait]
  sigma.site <- VarCorr(model)$site
  var.site <- sum(diag(W %*% sigma.site %*% t(W)))/n
  sigma.land <- VarCorr(model)$landscape
  var.landscape <- sum(diag(W %*% sigma.land %*% t(W)))/n
  
  
  # variance (1|landscape:sp) and (1|site:sp)
  var.landscape.sp <- VarCorr(model)$`landscape:sp`[1]
  var.site.sp <- VarCorr(model)$`site:sp`[1]
  
  
  denominador <- var.f + var.sp + var.landscape + var.site + var.landscape.sp +
    var.site.sp + pi^2/3
  
  r2.fix <- var.f/denominador
  r2.cond <- (var.f + var.sp + var.landscape + var.site + var.landscape.sp +
                var.site.sp)/denominador
  
  res <- data.frame(overall = round(r2.cond,3),
                    fixed.effects = round(r2.fix,3),
                    sp = round(var.sp/denominador, 3),
                    landscape.sp = round(var.landscape.sp/denominador, 3),
                    site.sp = round(var.site.sp/denominador, 3),
                    landscape = round(var.landscape/denominador, 3),
                    site = round(var.site/denominador, 3))
  return(res) 
}


# For models without traits
r.quad <- function(model, coefs= "fc400"){
  
  coefs = c("(Intercept)", coefs)
  
  # variância efeitos fixos
  var.f <- var(as.vector(fixef(model) %*% t(model@pp$X)))
  
  # variância do intercepto e inclinação juntos pq são correlacionados
  X <- model.matrix(model)
  n <- nrow(X)
  Z <- X[,coefs]
  
  sigma <- VarCorr(model)$sp
  
  var.sp <- sum(diag(Z %*% sigma %*% t(Z)))/n
  
  var.landscape.sp <- VarCorr(model)$`landscape:sp`[1]
  
  var.site.sp <- VarCorr(model)$`site:sp`[1]
  
  var.landscape <- VarCorr(model)$landscape[1]
  
  var.site <- VarCorr(model)$site[1]
  
  denominador <- var.f + var.sp + var.landscape + var.site + var.landscape.sp +
    var.site.sp + pi^2/3
  
  r2.fix <- var.f/denominador
  r2.cond <- (var.f + var.sp + var.landscape + var.site + var.landscape.sp +
                var.site.sp)/denominador
  
  res <- data.frame(componente = c("overall", "fixed.effects", "sp", "landscape.sp",
                                   "site.sp", "landscape", "site"),
                    valores = round(c(r2.cond, r2.fix, c(var.sp, var.landscape.sp,
                                                         var.site.sp, var.landscape, var.site)/denominador), 3))
  return(res) 
}
