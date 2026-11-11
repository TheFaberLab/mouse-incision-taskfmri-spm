%-----------------------------------------------------------------------
% Job saved on 10-Aug-2021 16:07:58 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
%% convert the 3D.nii files done with slice timing correction to a 4D.nii file
matlabbatch{1}.spm.util.cat.vols = anms;
matlabbatch{1}.spm.util.cat.name = aname;
matlabbatch{1}.spm.util.cat.dtype = 4;
matlabbatch{1}.spm.util.cat.RT = NaN;
%% convert the 3D.nii files done with slice timing correction and realignment to a 4D.nii file
matlabbatch{2}.spm.util.cat.vols = ranms ;
matlabbatch{2}.spm.util.cat.name = raname;
matlabbatch{2}.spm.util.cat.dtype = 4;
matlabbatch{2}.spm.util.cat.RT = NaN;
%% convert the 3D.nii files done with slice timing correction, realignment and smoothing to a 4D.nii file
matlabbatch{3}.spm.util.cat.vols = sranms ;
matlabbatch{3}.spm.util.cat.name = sraname;
matlabbatch{3}.spm.util.cat.dtype = 4;
matlabbatch{3}.spm.util.cat.RT = NaN;
%% convert the 3D.nii files done with increasing voxel size to a 4D.nii file
matlabbatch{4}.spm.util.cat.vols = vnms ;
matlabbatch{4}.spm.util.cat.name = vname;
matlabbatch{4}.spm.util.cat.dtype = 4;
matlabbatch{4}.spm.util.cat.RT = NaN;
%% deletel 3D.nii files except for the smoothed ones
matlabbatch{5}.cfg_basicio.file_dir.file_ops.file_move.files = anms;
matlabbatch{5}.cfg_basicio.file_dir.file_ops.file_move.action.delete = false;
matlabbatch{6}.cfg_basicio.file_dir.file_ops.file_move.files = ranms;
matlabbatch{6}.cfg_basicio.file_dir.file_ops.file_move.action.delete = false;
matlabbatch{7}.cfg_basicio.file_dir.file_ops.file_move.files = dfnms;
matlabbatch{7}.cfg_basicio.file_dir.file_ops.file_move.action.delete = false;
matlabbatch{8}.cfg_basicio.file_dir.file_ops.file_move.files = vnms;
matlabbatch{8}.cfg_basicio.file_dir.file_ops.file_move.action.delete = false;

spm_jobman('run', matlabbatch);
