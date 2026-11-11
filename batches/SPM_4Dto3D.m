%-----------------------------------------------------------------------
% Job saved on 10-Aug-2021 11:03:53 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.util.split.vol = {niftifile2};
matlabbatch{1}.spm.util.split.outdir = {preprocessed};
%%
spm_jobman('run', matlabbatch);
