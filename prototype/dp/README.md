## Notebooks

Each `#.#-prototype.ipynb` notebook gives an experiment. Increasing numbers roughly indicate chronological order and don't necessarily indicate improved performance. 

### Experiments

#### 0.0-prototype.ipynb

The baseline prototype. It shows that mean-encoding and XGBoost works quite well. An example validation performance was an f1 value of 0.732, whereas the best current test performance for the competition is 0.754.

From listing the feature importances of the XGBoost model, it appears that the most important features are the geographic features, particularly the less granular ones. The next important features appear to relate to the structure of the building. Some top features specifically were: `geo_level_3`, `geo_level_2`, `ground_floor_type`, `roof_type`, and `foundation_type`.

#### 0.1-prototype-try-one-encoding.ipynb

In the baseline, the mean-encoding procedure created 3 normalized mean values for each of the three categorical damage variables. This notebook tried using just the mean damage *value* (a value between 1 and 3). The same was done for the std-encoding. This reduced the initial input dimensions to XGBoost (and training time) by about a half, without any apparent drop in performance (though performance comparisons weren't rigorous: this is why a fixed train/validation split is needed).

Another benefit is that it is easier to read the resulting list of feature importances of the XGBoost model.

#### 0.2-prototype-try-bucketing.ipynb

When the mean-encoding procedure of the previous notebooks was used on the interaction features (eg. `age_mul_area=df.age * df.area_percentage`) or the features `area_percentage` or `height_percentage`, it would create a discrete mapping over a continuous variable. This means that rare feature values would map to the mean of just a few training examples. Even worse, previously unseen feature values would map to NaN.

I tried to create a more proper discrete mapping by bucketing over *intervals*. The end result was little change in performance, as the resulting features appear to still be relatively insignificant compared to geographic location and structural attributes of the building (like floor, roof, and foundation).

#### create_fixed_cross_validation_split

After issues with comparing metrics, I decided to make a fixed train/validation split.

#### 0.3-prototype-try-ablation.ipynb

I tried training XGBoost models on single feature examples, 2 feature examples, and one set of the top 8 features (ranked by importance to previous XGBoost models). While best model so far achieves a validation f1-score of 0.7349, a model trained on JUST `geo_level_3_id_labelEnc` can already achieve 0.7076! Top single-feature validation f1-scores:
* `geo_level_2_id_labelEnc`: 0.7076
* `geo_level_2_id_labelEnc`: 0.6914
* `geo_level_3_id_labelEncStd`: 0.6007
* `foundation_type_i`: 0.5754
Some double-feature validation f1-scores:
* `geo_level_3_id_labelEnc` and `geo_level_3_id_labelEncStd`: 0.7113
* `geo_level_3_id_labelEnc` and `foundation_type_i`: 0.7170
* `geo_level_3_id_labelEnc` and `roof_type_x`: 0.7163
* `geo_level_3_id_labelEnc` and `geo_level_2_id_labelEnc`: 0.7109
A model trained on the top 8 features (out of over 100 original features) yielded a validation f1-score of 0.7245. The features: `geo_level_3_id_labelEnc`, `geo_level_2_id_labelEnc`, `foundation_type_i`, `foundation_type_r`, `ground_floor_type_v`, `roof_type_x`, `geo_level_3_id_labelEncStd`, `ground_floor_type_labelEnc`.

I also used the new *fixed* train/validation splits for this Notebook (specifically, split number 0). I will use this from now on so that metrics are comparable.

#### 0.4-prototype-try-count-encoding.ipynb

I noticed that the mean-encoding doesn't take into account the number of counts that led to that mean. The number of counts should really affect our confidence in that mean though! In light of this, I added the count-encoding to see if it helped. The new model achieved an f1-score of 0.7353, which is somewhat better than the previous models 0.7349 (but maybe not significantly so?)

#### 0.5-prototype-try-smooth-mean-encoding.ipynb

A better way to approach the problem mentioned in the previous experiment (uncertain statistical measurements for target-encoding with small samples) is to use smoothing. Inspired by a blog post (https://maxhalford.github.io/blog/target-encoding-done-the-right-way/), I added smoothing to the mean and std encodings. The resulting model has a validation f1-score of 0.7395, which is about 0.0046 better (nearly half a raw percent more accurate) than the original model.

### TODO

* Experiment with different values for the smoothing parameter (I only tried m=1).
* I'm working on a simple DNN model that I might try to ensemble with the XGBoost model.
