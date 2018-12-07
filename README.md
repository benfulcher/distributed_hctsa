# distributed_hctsa
Code for distributing highly comparative time-series analysis computations, using [hctsa](), on a computing cluster using pbs or slurm using Matlab (and without linking to a mySQL database).

A template set of files for Matlab-based distributed computing for *hctsa* calculations on a cluster with `qsub`.

The parent directory should contain an `HCTSA.mat` file (produced with `TS_init` that you wish to compute features for) as well as these files will generate a set of directories containing subsets of time series (as specified in `HCTSA_run.sh`)
Can run as:
```bash
./HCTSA_run.sh
```
