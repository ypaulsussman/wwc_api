## Initial Data Corruptions (Contact WWC Later)
- Malformed CSV's (_see scrubbers for steps to fix_)
- In `reviewdictionary`: `reviewid` field is missing from `studies` and `findings`
- In `studies`: `demographics_of_study_sample_international` is `boolean`, not `percent`
- In `studies`: `ethnicity_hispanic` and `ethnicity_not_hispanic` are `percent`, not `boolean`
- In `studies`: `productid` doesn't map to unique `product_name` for ID's ( 1, 11, 12, 14, 15, 18, 19, 21, 22, 23)
- In `studies`: `study_design` undercounts `Randomized c/Controlled t/Trial` by case-sensitive split in records
- In `intervention_reports`: `outcome_domain` is `text`, not `int`
- All `boolean` values coded as `1.00`, save for those in the `Topic_*` subset, which are coded as `1`
- Nit, but why is `Program_Type` capitalized, while `Class_type` and `School_type` are not?
