# OtktSurvey

This repository has submodules. Clone it with:
```
git clone --recurse-submodules https://github.com/Misrobody/OtktSurvey.git
```

## Usage 

You can either use the docker and open the notebook INSTRUCTIONS.ipynb:
```
docker run -p 8888:8888 kieker/otkt-dsl-survey
```

Or follow the [instructions](INSTRUCTIONS.md) from your own environment.

If you are using your own environment, we will need to install two custom python packages using pip. In order to not mess with your current setup, we will be using a virtual environment.

Activate the environment.

```bash
source .venv/bin/activate
```

At the end of the survey, you can desactivate the environment.

```bash
deactivate
```
