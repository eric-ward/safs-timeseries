data {
  int<lower=1> N; // num observations
  real y[N]; // observed outputs
}
parameters {
  real mu; // mean coeff
  real phi; // autoregression coeff
  real theta; // moving avg coeff
  real<lower=0> sigma; // noise scale
}
model {
  vector[N] pred; // prediction for time t
  vector[N] err; // error for time t
  pred[1] = mu + phi * mu; // assume err[0] == 0
  err[1] = y[1] - pred[1];
  for (t in 2:N) {
    pred[t] = mu + phi * y[t-1] + theta * err[t-1];
    err[t] = y[t] - pred[t];
  }

mu ~ normal(0, 10); // priors
phi ~ normal(0, 2);
theta ~ normal(0, 2);
sigma ~ cauchy(0, 5);
err ~ normal(0, sigma);
}