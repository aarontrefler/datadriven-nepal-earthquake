# Overview
Run notebook to produce datasets and predictions.
Ensure all competition files are placed in `data/raw/`

# Competition Details
https://www.drivendata.org/competitions/57/nepal-earthquake/

# Future Ideas

## Feature Engineering Ideas
- Imagesc of all features 
- Standard deviation over damage_grade not dummies
- Numerical feature averages by geo_level_id
- Frequencies by geo_level_id
- Look closer into geo_id (e.g., does level 3 always occur in lvl 2)

## Modeling Ideas
- Hyper-parameter tuning
- Dedicated XGB Classifiers for classes 1 and 3 + ensemble is confidence is high

## Workflow Ideas
- ML FLow