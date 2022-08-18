#!/bin/bash
#SBATCH --ntasks-per-node=2
#SBATCH --time=1:00:00
#SBATCH --job-name=test_job
#SBATCH --mem=1G
#SBATCH --error=testerror_%j.error
#SBATCH --cpus-per-task=1
#SBATCH --output=testoutput_%j.out
#SBATCH --gres=gpu:2
#SBATCH --nodelist=cuda1
export PATH="/opt/anaconda3/bin:$PATH"
source /opt/anaconda3/etc/profile.d/conda.sh
git clone https://github.com/gdewael/cpg-transformer.git
cd cpg-transformer
conda env create -f environment.yml
conda activate cpgtransformer

mkdir reproduce_Hemato
cd reproduce_hemato
wget https://transfer.sh/41TJ0m/pos.npz
wget https://transfer.sh/4qR67i/y.npz
wget https://transfer.sh/GGpjX2/X.npz
cd ../

python train_cpg_transformer.py reproduce_Hemato/X_ser.npz reproduce_Hemato/y_ser.npz reproduce_Hemato/pos_ser.npz --log_folder logfolder --experiment_name reproduce_results 