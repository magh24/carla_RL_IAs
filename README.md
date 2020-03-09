# End-to-End Model-Free Reinforcement Learning for Urban Driving using Implicit Affordances

This repo contains the inference code and the weights of our [**paper**](https://arxiv.org/abs/1911.10868)
accepted at CVPR 2020. 
It's a fork of the repository [**Learning by Cheating**](https://github.com/dianchen96/LearningByCheating) 
from which we just kept all the code related to the evaluation on the standard CARLA
benchmark and on the new released No-Crash benchmark.

### Installation
We provide a script here to install and download our weights:

```bash
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
```

Then, open up a terminal, inside the carla directory run `./CarlaUE4.sh -fps=10 -benchmark`. 
Open another terminal and run `python benchmark_agent.py --suite=town2 
--max-run 100 --path-folder-model model_RL_IAs_only_town01_train_weather/ --render --crop-sky` 
to see our model driving on test town!

If you want to see our model used for the CARLA challenge you need to run instead
`python benchmark_agent.py --suite=town2 
--max-run 100 --path-folder-model model_RL_IAs_CARLA_Challenge/ --render` 


## Detailed Benchmark Results
### Only town01/train weather
```
╔Performance of autopilot════════════╦═════════╦═══════╗
║ Suite Name          ║ Success Rate ║ Total   ║ Seeds ║
╠═════════════════════╬══════════════╬═════════╬═══════╣
║ FullTown01-v1       ║ 100          ║ 100/100 ║ 2019  ║
║ FullTown01-v2       ║ 100          ║ 50/50   ║ 2019  ║
║ FullTown01-v3       ║ 100          ║ 100/100 ║ 2019  ║
║ FullTown01-v4       ║ 100          ║ 50/50   ║ 2019  ║
║ FullTown02-v1       ║ 99           ║ 99/100  ║ 2019  ║
║ FullTown02-v2       ║ 96           ║ 48/50   ║ 2019  ║
║ FullTown02-v3       ║ 98           ║ 98/100  ║ 2019  ║
║ FullTown02-v4       ║ 92           ║ 46/50   ║ 2019  ║
║ NoCrashTown01-v1    ║ 100          ║ 100/100 ║ 2019  ║
║ NoCrashTown01-v2    ║ 24           ║ 12/50   ║ 2019  ║
║ NoCrashTown01-v3    ║ 99           ║ 99/100  ║ 2019  ║
║ NoCrashTown01-v4    ║ 26           ║ 13/50   ║ 2019  ║
║ NoCrashTown01-v5    ║ 67           ║ 67/100  ║ 2019  ║
║ NoCrashTown01-v6    ║ 14           ║ 7/50    ║ 2019  ║
║ NoCrashTown02-v1    ║ 97           ║ 97/100  ║ 2019  ║
║ NoCrashTown02-v2    ║ 18           ║ 9/50    ║ 2019  ║
║ NoCrashTown02-v3    ║ 86           ║ 86/100  ║ 2019  ║
║ NoCrashTown02-v4    ║ 14           ║ 7/50    ║ 2019  ║
║ NoCrashTown02-v5    ║ 44           ║ 44/100  ║ 2019  ║
║ NoCrashTown02-v6    ║ 14           ║ 7/50    ║ 2019  ║
║ StraightTown01-v1   ║ 100          ║ 100/100 ║ 2019  ║
║ StraightTown01-v2   ║ 100          ║ 50/50   ║ 2019  ║
║ StraightTown02-v1   ║ 100          ║ 100/100 ║ 2019  ║
║ StraightTown02-v2   ║ 100          ║ 50/50   ║ 2019  ║
║ TurnTown01-v1       ║ 100          ║ 100/100 ║ 2019  ║
║ TurnTown01-v2       ║ 100          ║ 50/50   ║ 2019  ║
║ TurnTown02-v1       ║ 99           ║ 99/100  ║ 2019  ║
║ TurnTown02-v2       ║ 100          ║ 50/50   ║ 2019  ║
╚═════════════════════╩══════════════╩═════════╩═══════╝
```

### CARLA Challenge (town02/04/05 with dynamic weather) (ONGOING)

```
COMING SOON
```

## License
This repo is released under the MIT License (please refer to the LICENSE file for details). Part of the PythonAPI and the map rendering code is borrowed from the official [CARLA](https://github.com/carla-simulator/carla) repo, which is under MIT license. The image augmentation code is borrowed from [Coiltraine](https://github.com/felipecode/coiltraine) which is released under MIT license.
