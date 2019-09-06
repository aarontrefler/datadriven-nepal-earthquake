## Notebooks

Each `#.#-prototype.ipynb` notebook gives an experiment. Increasing numbers roughly indicate chronological order and don't necessarily indicate improved performance. 

### Experiments

#### 0.0-prototype.ipynb

The baseline prototype. It shows that mean-encoding and XGBoost works quite well. An example validation performance was an f1 value of 0.732, whereas the best current test performance for the competition is 0.754.

From listing the feature importances of the XGBoost model, it appears that the most important features are the geographic features, particularly the less granular ones. The next important features appear to relate to the structure of the building. Some top features specifically were: `geo_level_3`, `geo_level_2`, `ground_floor_type`, `roof_type`, and `foundation_type`.

#### 0.1-prototype-try-one-encoding.ipynb

In the baseline, the mean-encoding procedure created 3 normalized mean values for each of the three categorical damage variables. This notebook tried using just the mean damage *value* (a value between 1 and 3). The same was done for the std-encoding. This reduced the initial input dimensions to XGBoost (and training time) by about a half, without any apparent drop in performance (though performance comparisons weren't rigorous: see TODO section).

Another benefit is that it is easier to read the resulting list of feature importances of the XGBoost model.

#### 0.2-prototype-try-bucketing.ipynb

When the mean-encoding procedure of the previous notebooks was used on the interaction features (eg. `age_mul_area=df.age * df.area_percentage`) or the features `area_percentage` or `height_percentage`, it would create a discrete mapping over a continuous variable. This means that rare feature values would map to the mean of just a few training examples. Even worse, previously unseen feature values would map to NaN.

I tried to create a more proper discrete mapping by bucketing over *intervals*. The end result was little change in performance, as the resulting features appear to still be relatively insignificant compared to geographic location and structural attributes of the building (like floor, roof, and foundation).

### TODO

* Create a fixed train/validation split for better comparisons of experiments.
 * Since the validation performance already appears to be fairly close to the best test performance for the competition, apparently small changes in f1 score may actually be quite significant.
 * We can create multiple fixed train/validation splits if we like.
