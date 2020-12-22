## testando interação cob local e paisagem


bodyhigh.spe1 <- glmer(cbind(occor, n.visit-occor) ~  forest_site400*forest_land +
                        forest_site400*lbody_size + forest_land*lbody_size +
                        (forest_site400 * forest_land|sp) + (1|landscape:sp) + (1|site:sp) + 
                        (lbody_size|landscape) + (lbody_size|site),
                      family=binomial, data=high.spe,
                      nAGQ = 1, control = glmerControl(optimizer = "bobyqa",
                                                       optCtrl = list(maxfun = 500000)))
