#!/bin/bash

subj=$1
subj_dir=$2
n=$3

func_dir="${subj_dir}/MNINonLinear/Results"
struct_dir="${subj_dir}/fmriresults01/${subj}_V1_MR/T1w/fsaverage_LR32k"


kernel=6
for tseries in REST${n}_AP REST${n}_PA; do

    raw="${func_dir}/${tseries}/rfMRI_${tseries}_Atlas_MSMAll_hp0_clean.dtseries.nii"
    smooth="${func_dir}/${tseries}/rfMRI_${tseries}_Atlas_MSMAll_hp0_clean_smooth.dtseries.nii"
    
    if [ -f "${out_tseries}" ]; then continue

    wb_command  -cifti-smoothing "${raw} ${kernel} ${kernel} COLUMN ${smooth}" \
                -left-surface "${struct_dir}/${subj}_V1.L.midthickness_MSMAll.32k_fs_LR.surf.gii" \
                -right-surface "${struct_dir}/${subj}_V1.R.midthickness_MSMAll.32k_fs_LR.surf.gii"
done


out_tseries="${func_dir}/rfMRI_REST${n}_Atlas_MSMAll_hp0_clean_smooth.dtseries.nii"

if [ ! -f "${out_tseries}" ]; then
    wb_command  -cifti-merge "${out_tseries}" \
                -cifti "${func_dir}/REST${n}_AP/rfMRI_REST${n}_AP_Atlas_MSMAll_hp0_clean_smooth.dtseries.nii" \
                -cifti "${func_dir}/REST${n}_PA/rfMRI_REST${n}_PA_Atlas_MSMAll_hp0_clean_smooth.dtseries.nii"
fi




