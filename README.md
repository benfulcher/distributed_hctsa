# distributed_hctsa
Running *hctsa* on a cluster (qsub)

A template set of files for Matlab-based distributed computing for *hctsa* calculations on a cluster with `qsub`.

The parent directory should contain an `HCTSA.mat` file (produced with `TS_init` that you wish to compute features for) as well as these files will generate a set of directories containing subsets of time series (as specified in `HCTSA_run.sh`)
Can run using `./HCTSA_run.sh`
