/* Creator: Sarah Quander
Date: 06.15.16
*/

*Retrieving Data
cd~
cd ~/Documents
import  excel using "stata data.xlsx", firstrow clear

*Generage accurate age
local age_types ca ma 
foreach type in `age_types' {
	generate `type'_age = `type'_y*12+`type'_m
	replace `type'_age = `type'_age/12
	}

/*local var_age ca ma 
foreach type in '`var_age'{
	replace `var'_age = round(`var'_age,1)
	}*/

replace ma_age = round(ma_age,1)
replace ca_age = round(ca_age, 1)

*Encode sex
encode sex, generate(sex2)

/*IQ scatter plots
twoway(scatter iq ca_age), title(IQ v. Age)
twoway(scatter iq ca_age if sex2 == 1), title(Female: IQ v Age)
twoway(scatter iq ca_age if sex2 == 2), title(Male: IQ v Age)
twoway(scatter iq ma_age), title(IQ v Mental Age)

*Connected graphs
twoway(connected iq ma_age if ca_age == 5)
twoway(connected iq ma_age if ca_age == 5 & sex2 == 1), lcolor(red)  //
twoway(connected iq ma_age if ca_age == 5 & sex2 == 2)
graphcombine
*/ 

local vars_to_reshape date_test_y date_test_m date_test_d birth_date_y ///
						birth_date_m birth_date_d ca_y ca_m ma_y ma_m iq ///
						factors a24i1 a24i1tot a24i1a a24i1b a24i2 a24i2tot ///
						a24i2a a24i2b a24i2c a24i3 a24i3tot a24i3a a24i3b ///
						a24i3c a24i3d a24i3e a24i3f a24i3g a24i4 a24i4tot a24i5 a24i5tot a24i6 a24i6tot a24i6A a24i6Atot a30i1 a30i1tot a30i1a a30i1b a30i1c a30i1d a30i1e a30i1f a30i2 a30i2tot a30i3 a30i3tot a30i3a a30i3b a30i3c a30i3d a30i3e a30i3f a30i4 a30i4tot a30i5 a30i5tot a30i5a a30i5b a30i5c a30i6 a30i6tot a30i6a a30i6b a30i6c a30i6A a30i6Atot a30i6Aa a30i6Ab a30i6Ac a36i1 a36i1tot a36i2 a36i2tot a36i3 a36i3tot a36i4 a36i4tot a36i4a a36i4b a36i5 a36i5tot a36i5a a36i5b a36i5c a36i6 a36i6tot a36i6A a36i6Atot a36i6Aa a36i6Ab a36i6Ac a42i1 a42i1tot a42i1a a42i1b a42i1c a42i1d a42i1e a42i1f a42i2 a42i2tot a42i2a a42i2b a43i3 a42i3tot a42i4 a42i4tot a42i4a a42i4b a42i4c a42i5 a42i5tot a42i6 a42i6tot a42i6a a42i6b a64i6A a46i6Atot a46i6Aa a64i6Ab a64i6Ac a64i6Ad a64i6Ae a64i6Af a48i1 a48i1tot a48i2 a48i2tot a48i2a a48i2b a48i2c a48i3 a48i3tot a48i3a a48i3b a48i3c a48i3d a48i3e a48i4 a48i4tot a48i4a a48i4b a48i4c a48i4d a48i4e a48i4f a48i5 a48i5tot a48i6 a48i6tot a48i6a a48i6b a48i6A a48i6Atot a48i6Aa a48i6Ab a54i1 a54i1tot a54i1a a54i1b a54i1c a54i2 a54i2tot a54i3 a54i3tot a54i4 a54i4tot a54i4a a54i4b a54i4c a54i5 a54i5tot a54i5a a54i5b a54i5c a54i6 a54i6tot a54i6a a54i6b a54i6A a54i6Atot a60i1 a60i1tot a60i2 a60i2tot a60i3 a60i3tot a60i3a a60i3b a60i3c a60i4 a60i4tot a60i4a a60i4b a60i4c a60i5 a60i5tot a60i5a a60i5b a60i5c a60i5d a60i5e a60i5f a60i5g a60i5h a60i5i a60i5j a60i6 a60i6tot a60i6a a60i6b a60i6c a60i6A a60i6Atot a72i1 a72i1tot a72i2 a72i2tot a72i2a a72i2b a72i2c a72i3 a72i3tot a72i3a a72i3b a72i3c a72i3d a72i3e a72i4 a72i4tot a72i4a a72i4b a72i4c a72i4d a72i4e a72i5 a72i5tot a72i5a a72i5b a72i5c a72i5d a72i6 a72i6tot a72i6a a72i6b a72i6c a72i6A a72i6Atot a84i1 a84i1tot a84i1a a84i1b a84i1c a84i1d a84i1e a84i2 a84i2tot a84i2a a84i2b a84i2c a84i2d a84i3 a84i3tot a84i3a a84i3b a84i3c a84i4 a84i4tot a84i4a a84i4b a84i4c a84i4d a84i4e a84i4f a84i5 a84i5tot a84i5a a84i5b a84i5c a84i5d a84i6 a84i6tot a84i6a a84i6b a84i6c a84i6A a84i6Atot a84i6Aa a84i6Ab a84i6Ac a96i1 a96i1tot a96i2 a96i2tot a96i2a a96i2b a96i2c a96i2d a96i2e a96i2f a96i3 a96i3tot a96i3a a96i3b a96i3c a96i3d a96i4 a96i4tot a96i4a a96i4b a96i4c a96i4d a96i5 a96i5tot a96i6 a96i6tot a96i6a a96i6b a96i6c a96i6A a96i6Atot a96i6Aa a96i6Ab a96i6Ac a108i1 a108i1tot a108i1a a108i1b a108i2 a108i2tot a108i2a a108i2b a108i2c a108i2d a108i2e a108i3 a108i3tot a108i3a a108i3b a108i4 a108i4tot a108i4a a108i4b a108i4c a108i4d a108i5 a108i5tot a108i5a a108i5b a108i5c a108i6 a108i6tot a108i6a a108i6b a108i6c a108i6A a108i6Atot a108i6Aa a108i6Ab a108i6Ac a120i1 a120i1tot a120i2 a120i2tot a120i3 a120i3tot a120i3a a120i3b a120i3c a120i3d a120i4 a120i4tot a120i4a a120i4b a120i5 a120i5tot a120i6 a120i6tot a120i6a a120i6b a120i6c a120i6A a120i6Atot a120i6Aa a120i6Ab a120i6Ac a131i1 a131i1tot a131i2 a131i2tot a131i2a a131i2b a131i2c a131i3 a131i3tot a131i3a a131i3b a131i3c a131i3d a131i3e a131i4 a131i4tot a131i4a a131i4b a131i5 a131i5tot a131i6 a131i6tot a131i6a a131i6b a131i6c a131i6d a131i6e a131i6A a131i6Atot a131i6Aa a131i6Ab a144i1 a144i1tot a144i2 a144i2tot a144i3 a144i3tot a144i4 a144i4tot a144i4a a144i4b a144i4c a144i5 a144i5tot a144i6 a144i6tot a144i6A a144i6Atot a156i1 a156i1tot a156i2 a156i2tot a156i3 a156i3tot a156i3a a156i3b a156i4 a156i4tot a156i4a a156i4b a156i4c a156i5 a156i5tot a156i5a a156i5b a156i5c a156i6 a156i6tot a156i6A a156i6Atot a168i1 a168i1tot a168i2 a168i2tot a168i2a a168i2b a168i2c a168i2d a168i2e a168i2f a168i2g a168i3 a168i3tot a168i4 a168i4tot a168i4a a168i4b a168i4c a168i5 a168i5tot a168i5a a168i5b a168i5c a168i5d a168i5e a168i6 a168i6tot a168i6a a168i6b a168i6c a168i6d a168i6e a168i6A a168i6Atot a168i6Aa a168i6Ab a168i6Ac v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v14 v15 v16 v17 v18 v19 v20 v21 v22 v24 v25 v26 v27 v28 v29 v30 v31 v32 v34 v35 v36 v37 v38 v39 v40 v41 v42 v44 v45 ma_age
reshape wide `vars_to_reshape', i(id) j(ca_age)

drop sex
drop v13
drop v23
drop v33
drop v43

drop if id == 7  
drop if id == 10 
drop if id == 15 
drop if id == 16
drop if id == 18
drop if id == 19
drop if id == 21
drop if id == 22
drop if id == 25
drop if id == 30
drop if id == 34
drop if id == 35
drop if id == 37


// now time to merge

* change into the directory that has the other perry data (the data to merge in)
* use merge command

* merge 1:1 id using base-perry
