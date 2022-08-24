#!/bin/bash

#SBATCH --ntasks-per-node=1
#SBATCH --time=1-00:00:00
#SBATCH --job-name=test_job
#SBATCH --mem=16G
#SBATCH --error=%j.error
#SBATCH --cpus-per-task=1
#SBATCH --output=%j.out
#SBATCH --nodelist=cuda1
#SBATCH --partition=gpu_queue

echo
echo Setting up virtual environment...
echo

export PATH="/opt/anaconda3/bin:$PATH"
source /opt/anaconda3/etc/profile.d/conda.sh

conda config --set ssl_verify no

echo environments list
conda env list
echo environments list end

conda create -n cpgtransformer python=3.9
conda activate cpgtransformer
pip install -r requirements.txt

echo
echo Environment activated...
echo

python train_cpg_transformer.py reproduce_Hemato/X_ser.npz reproduce_Hemato/y_ser.npz reproduce_Hemato/pos_ser.npz --log_folder logfolder --experiment_name reproduce_results 
