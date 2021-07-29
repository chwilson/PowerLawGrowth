
data {
  int<lower=0> N;
  vector[N] pop;
  vector[N] yr;
}


parameters {
 real<lower=0> beta; 
 real<lower=0> alpha; 
 real<lower=0> sigma; 
}

model {
  for(i in 1:N)
  pop[i] ~ normal((beta*((beta-yr[i])^-1))^alpha, sigma);
}





