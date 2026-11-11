%-----------------------------------------------------------------------
% Job saved on 06-Oct-2021 16:39:41 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
% v: voxel size x10, a: slice timing correction, r: realignment, s: smoothing
% scan parameters: 18 slices, TR 1 s, sequential ascending, reference slice 9
% all distances in mm of the x10 voxel size (200x200x500 um -> 2x2x5 mm)
%%
matlabbatch{1}.spm.util.reorient.srcfiles = fnms;
%%
matlabbatch{1}.spm.util.reorient.transform.transprm = [0 0 0 0 0 0 10 10 10 0 0 0];
matlabbatch{1}.spm.util.reorient.prefix = 'v';
matlabbatch{2}.spm.temporal.st.scans{1}(1) = cfg_dep('Reorient Images: Reoriented Images', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{2}.spm.temporal.st.nslices = 18;
matlabbatch{2}.spm.temporal.st.tr = 1;
matlabbatch{2}.spm.temporal.st.ta = 0.944444444444444;
matlabbatch{2}.spm.temporal.st.so = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18];
matlabbatch{2}.spm.temporal.st.refslice = 9;
matlabbatch{2}.spm.temporal.st.prefix = 'a';
matlabbatch{3}.spm.spatial.realign.estwrite.data{1}(1) = cfg_dep('Slice Timing: Slice Timing Corr. Images (Sess 1)', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','files'));
matlabbatch{3}.spm.spatial.realign.estwrite.eoptions.quality = 0.9;
matlabbatch{3}.spm.spatial.realign.estwrite.eoptions.sep = 5;
matlabbatch{3}.spm.spatial.realign.estwrite.eoptions.fwhm = 0;
matlabbatch{3}.spm.spatial.realign.estwrite.eoptions.rtm = 1;
matlabbatch{3}.spm.spatial.realign.estwrite.eoptions.interp = 2;
matlabbatch{3}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
matlabbatch{3}.spm.spatial.realign.estwrite.eoptions.weight = '';
matlabbatch{3}.spm.spatial.realign.estwrite.roptions.which = [2 1];
matlabbatch{3}.spm.spatial.realign.estwrite.roptions.interp = 4;
matlabbatch{3}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
matlabbatch{3}.spm.spatial.realign.estwrite.roptions.mask = 1;
matlabbatch{3}.spm.spatial.realign.estwrite.roptions.prefix = 'r';
matlabbatch{4}.spm.util.print.fname = 'realignment';
matlabbatch{4}.spm.util.print.fig.figname = 'Graphics';
matlabbatch{4}.spm.util.print.opts = 'png';
matlabbatch{5}.spm.spatial.smooth.data(1) = cfg_dep('Realign: Estimate & Reslice: Resliced Images (Sess 1)', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{1}, '.','rfiles'));
matlabbatch{5}.spm.spatial.smooth.fwhm = [4 4 10];
matlabbatch{5}.spm.spatial.smooth.dtype = 0;
matlabbatch{5}.spm.spatial.smooth.im = 0;
matlabbatch{5}.spm.spatial.smooth.prefix = 's';

%%
spm_jobman('run', matlabbatch);
