# Distributing _hctsa_ calculations on a computing cluster
Code for distributing highly comparative time-series analysis computations, using [hctsa](https://github.com/benfulcher/hctsa), on a computing cluster using pbs or slurm using Matlab (without linking to a mySQL database).

A basic pipeline:
1. Set up a large `HCTSA.mat` file for your computation on your local machine using `TS_init`.
2. Ensure that the _hctsa_ version on your computing cluster is identical to the local version used to run `TS_Init` (otherwise results could be inconsistent).
3. Transfer the (uncomputed) `HCTSA.mat` file onto the cluster
4. Set the parameters `tsmin`, `tsmax`, and `NumPerJob` in `HCTSA_run.sh`.
   These parameters determine how `HCTSA.mat` will be distributed into segments, each of which will be submitted as a cluster job.
5. Run `HCTSA_run.sh` in the parent directory which should contain the `HCTSA.mat` file.
   This will generate a set of directories containing subsets of time series.
6. When all computations are complete, stitch all the subsections of the main `HCTSA` file back together again using `combineBatchFiles`. This yields a fully computed `HCTSA.mat` file. :smile:
