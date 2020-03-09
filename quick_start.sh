# Download CARLA 0.9.6
wget http://carla-assets-internal.s3.amazonaws.com/Releases/Linux/CARLA_0.9.6.tar.gz
mkdir carla_RL_IAs
tar -xvzf CARLA_0.9.6.tar.gz -C carla_RL_IAs
cd carla_RL_IAs

# Download LBC
mv LICENSE LICENSE_CARLA # Conflict with LICENSE from CARLA
git init
git remote add origin https://github.com/marintoro/LearningByCheating.git
git pull origin master
wget http://www.cs.utexas.edu/~dchen/lbc_release/navmesh/Town01.bin
wget http://www.cs.utexas.edu/~dchen/lbc_release/navmesh/Town02.bin
mv Town*.bin CarlaUE4/Content/Carla/Maps/Nav/

# Create conda environment
conda env create -f environment.yml
conda activate carla_RL_IAs
# BE CAREFUL: you need to install pytorch according to your cuda version
#conda install pytorch torchvision cudatoolkit=10.1 -c pytorch 
#conda install pytorch torchvision cudatoolkit=10.0 -c pytorch
conda install pytorch==1.1.0 torchvision==0.3.0 cudatoolkit=9.0 -c pytorch
pip install --upgrade pip
pip install pygame

# Install carla client
cd PythonAPI/carla/dist
rm carla-0.9.6-py3.5-linux-x86_64.egg
wget http://www.cs.utexas.edu/~dchen/lbc_release/egg/carla-0.9.6-py3.5-linux-x86_64.egg
easy_install carla-0.9.6-py3.5-linux-x86_64.egg

# Download model checkpoints trained only on Town01
wget https://github.com/marintoro/LearningByCheating/releases/download/v1.0/model_RL_IAs_only_town01_train_weather.zip
unzip model_RL_IAs_only_town01_train_weather.zip


# Download model checkpoints used for CARLA challenge
cd ../../..
wget https://github.com/marintoro/LearningByCheating/releases/download/v1.0/model_RL_IAs_CARLA_Challenge.zip
unzip model_RL_IAs_CARLA_Challenge.zip
