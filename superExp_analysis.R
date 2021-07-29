library(dplyr); library(ggplot2)

wp <- read.csv("WorldPop.csv")
str(wp)

wp %>% 
  ggplot(aes(x=Year,y=Pop)) + 
  geom_point()


hum_dat <- list(N = length(wp$Pop),pop=wp$Pop, yr = wp$Year)

library(rstan)
options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)


mod1 <- stan(file = "human_superexp.stan", data = hum_dat, 
             chains = 4, iter = 500)