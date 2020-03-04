# End-to-End Model-Free Reinforcement Learning for Urban Driving using Implicit Affordances

This repo contains the inference code and the weights of the paper. It's a fork of the
repository [**Learning by Cheating**](https://github.com/dianchen96/LearningByCheating) 
from which we just kept all the code related to the evaluation on the standard CARLA
benchmark and on the new release No-Crash benchmark.

### Installation
We provide a quick script here in case you would like to skip compiling and directly use the official binary release:

```bash
# Download CARLA 0.9.6
wget http://carla-assets-internal.s3.amazonaws.com/Releases/Linux/CARLA_0.9.6.tar.gz
mkdir carla_RL_IAs
tar -xvzf CARLA_0.9.6.tar.gz -C carla_RL_IAs
cd carla_RL_IAs

# Download LBC
git init
git remote add origin https:///github.com/marintoro/LearningByCheatingg.git
git pull origin release-0.9.6
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

# Install carla client
cd PythonAPI/carla/dist
rm carla-0.9.6-py3.5-linux-x86_64.egg
wget http://www.cs.utexas.edu/~dchen/lbc_release/egg/carla-0.9.6-py3.5-linux-x86_64.egg
easy_install carla-0.9.6-py3.5-linux-x86_64.egg

# Download model checkpoints used for CARLA challenge
cd ../../..
wget https://github.com/marintoro/LearningByCheating/releases/download/v1.0/model_RL_IAs_CARLA_Challenge.zip
tar -xvzf model_RL_IAs_CARLA_Challenge.zip

# Download model checkpoints trained only on Town01
wget https://github.com/marintoro/LearningByCheating/releases/download/v1.0/model_RL_IAs_only_town01_train_weather.zip
tar -xvzf model_RL_IAs_only_town01_train_weather.zip

cd ../..
```

Then, open up a terminal, inside the carla directory run `./CarlaUE4.sh -fps=10 -benchmark`. 
Open another terminal and run `CUDA_VISIBLE_DEVICES="0" python benchmark_agent.py --suite=town2 
--max-run 100 --path-folder-model model_RL_IAs_only_town01_train_weather/ --render --crop-sky` 
to see our model driving on test town!

If you want to see our model used for the CARLA challenge you need to run instead
`CUDA_VISIBLE_DEVICES="0" python benchmark_agent.py --suite=town2 
--max-run 100 --path-folder-model model_RL_IAs_CARLA_Challenge/ --render` 


## Detailed Benchmark Results
### Only town01/train weather (ONGOING)
```
╔Performance of autopilot════════════╦═════════╦═══════╗
║ Suite Name          ║ Success Rate ║ Total   ║ Seeds ║
╠═════════════════════╬══════════════╬═════════╬═══════╣
║ FullTown01-v1       ║ 100          ║ 100/100 ║ 0     ║
║ FullTown01-v2       ║ 100          ║ 50/50   ║ 0     ║
║ FullTown01-v3       ║ 100          ║ 100/100 ║ 0     ║
║ FullTown01-v4       ║ 100          ║ 50/50   ║ 0     ║
║ FullTown02-v1       ║ 100          ║ 100/100 ║ 0     ║
║ FullTown02-v2       ║ 100          ║ 50/50   ║ 0     ║
║ FullTown02-v3       ║ 100          ║ 100/100 ║ 0     ║
║ FullTown02-v4       ║ 100          ║ 50/50   ║ 0     ║
║ NoCrashTown01-v1    ║ 100.0 ± 0.0  ║ 300/300 ║ 0,1,2 ║
║ NoCrashTown01-v2    ║ 100.0 ± 0.0  ║ 150/150 ║ 0,1,2 ║
║ NoCrashTown01-v3    ║ 98.7 ± 0.6   ║ 296/300 ║ 0,1,2 ║
║ NoCrashTown01-v4    ║ 99.3 ± 1.2   ║ 149/150 ║ 0,1,2 ║
║ NoCrashTown01-v5    ║ 86.3 ± 3.2   ║ 259/300 ║ 0,1,2 ║
║ NoCrashTown01-v6    ║ 82.7 ± 6.1   ║ 124/150 ║ 0,1,2 ║
║ NoCrashTown02-v1    ║ 100.0 ± 0.0  ║ 300/300 ║ 0,1,2 ║
║ NoCrashTown02-v2    ║ 100.0 ± 0.0  ║ 150/150 ║ 0,1,2 ║
║ NoCrashTown02-v3    ║ 99.0 ± 1.0   ║ 297/300 ║ 0,1,2 ║
║ NoCrashTown02-v4    ║ 98.0 ± 2.0   ║ 147/150 ║ 0,1,2 ║
║ NoCrashTown02-v5    ║ 60.0 ± 2.6   ║ 180/300 ║ 0,1,2 ║
║ NoCrashTown02-v6    ║ 58.7 ± 7.6   ║ 88/150  ║ 0,1,2 ║
║ StraightTown01-v1   ║ 100          ║ 100/100 ║ 0     ║
║ StraightTown01-v2   ║ 100          ║ 50/50   ║ 0     ║
║ StraightTown02-v1   ║ 100          ║ 100/100 ║ 0     ║
║ StraightTown02-v2   ║ 100          ║ 50/50   ║ 0     ║
║ TurnTown01-v1       ║ 100          ║ 100/100 ║ 0     ║
║ TurnTown01-v2       ║ 100          ║ 50/50   ║ 0     ║
║ TurnTown02-v1       ║ 100          ║ 100/100 ║ 0     ║
║ TurnTown02-v2       ║ 100          ║ 50/50   ║ 0     ║
╚═════════════════════╩══════════════╩═════════╩═══════╝
```

### CARLA Challenge (town02/04/05 with dynamic weather) (ONGOING)

```
╔Performance of model-10═══════════╦═════════╦═══════╗
║ Suite Name        ║ Success Rate ║ Total   ║ Seeds ║
╠═══════════════════╬══════════════╬═════════╬═══════╣
║ FullTown01-v1     ║ 100          ║ 100/100 ║ 0     ║
║ FullTown01-v2     ║ 100          ║ 50/50   ║ 0     ║
║ FullTown01-v3     ║ 100          ║ 100/100 ║ 0     ║
║ FullTown01-v4     ║ 96           ║ 48/50   ║ 0     ║
║ FullTown02-v1     ║ 98           ║ 98/100  ║ 0     ║
║ FullTown02-v2     ║ 100          ║ 50/50   ║ 0     ║
║ FullTown02-v3     ║ 99           ║ 99/100  ║ 0     ║
║ FullTown02-v4     ║ 100          ║ 50/50   ║ 0     ║
║ NoCrashTown01-v1  ║ 97.0 ± 1.0   ║ 291/300 ║ 0,1,2 ║
║ NoCrashTown01-v2  ║ 86.7 ± 4.2   ║ 130/150 ║ 0,1,2 ║
║ NoCrashTown01-v3  ║ 93.3 ± 0.6   ║ 280/300 ║ 0,1,2 ║
║ NoCrashTown01-v4  ║ 87.3 ± 3.1   ║ 131/150 ║ 0,1,2 ║
║ NoCrashTown01-v5  ║ 70.7 ± 4.5   ║ 212/300 ║ 0,1,2 ║
║ NoCrashTown01-v6  ║ 63.3 ± 3.1   ║ 95/150  ║ 0,1,2 ║
║ NoCrashTown02-v1  ║ 99.7 ± 0.6   ║ 299/300 ║ 0,1,2 ║
║ NoCrashTown02-v2  ║ 70.0 ± 4.0   ║ 105/150 ║ 0,1,2 ║
║ NoCrashTown02-v3  ║ 94.0 ± 3.0   ║ 281/299 ║ 0,1,2 ║
║ NoCrashTown02-v4  ║ 62.0 ± 2.0   ║ 93/150  ║ 0,1,2 ║
║ NoCrashTown02-v5  ║ 51.3 ± 3.1   ║ 154/300 ║ 0,1,2 ║
║ NoCrashTown02-v6  ║ 38.7 ± 6.4   ║ 58/150  ║ 0,1,2 ║
║ StraightTown01-v1 ║ 100          ║ 100/100 ║ 0     ║
║ StraightTown01-v2 ║ 100          ║ 50/50   ║ 0     ║
║ StraightTown02-v1 ║ 100          ║ 100/100 ║ 0     ║
║ StraightTown02-v2 ║ 100          ║ 50/50   ║ 0     ║
║ TurnTown01-v1     ║ 100          ║ 100/100 ║ 0     ║
║ TurnTown01-v2     ║ 96           ║ 48/50   ║ 0     ║
║ TurnTown02-v1     ║ 100          ║ 100/100 ║ 0     ║
║ TurnTown02-v2     ║ 100          ║ 50/50   ║ 0     ║
╚═══════════════════╩══════════════╩═════════╩═══════╝
```

## License
This repo is released under the MIT License (please refer to the LICENSE file for details). Part of the PythonAPI and the map rendering code is borrowed from the official [CARLA](https://github.com/carla-simulator/carla) repo, which is under MIT license. The image augmentation code is borrowed from [Coiltraine](https://github.com/felipecode/coiltraine) which is released under MIT license.
