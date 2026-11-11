%-----------------------------------------------------------------------
% Job saved on 02-Sep-2021 22:07:26 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.cfg_basicio.file_dir.dir_ops.cfg_mkdir.parent = {parentpath};
matlabbatch{1}.cfg_basicio.file_dir.dir_ops.cfg_mkdir.name = foldername;
matlabbatch{2}.spm.stats.fmri_spec.dir(1) = cfg_dep(string, substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','dir'));
matlabbatch{2}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{2}.spm.stats.fmri_spec.timing.RT = 1;
matlabbatch{2}.spm.stats.fmri_spec.timing.fmri_t = 18;
matlabbatch{2}.spm.stats.fmri_spec.timing.fmri_t0 = 9;
%%
matlabbatch{2}.spm.stats.fmri_spec.sess.scans = snms;
%%
matlabbatch{2}.spm.stats.fmri_spec.sess.cond.name = 'MS 1Hz-10-10-10';
%%
matlabbatch{2}.spm.stats.fmri_spec.sess.cond.onset = onset;
%%
matlabbatch{2}.spm.stats.fmri_spec.sess.cond.duration = 10;
matlabbatch{2}.spm.stats.fmri_spec.sess.cond.tmod = 0;
matlabbatch{2}.spm.stats.fmri_spec.sess.cond.pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{2}.spm.stats.fmri_spec.sess.cond.orth = 1;
matlabbatch{2}.spm.stats.fmri_spec.sess.multi = {''};
matlabbatch{2}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});
matlabbatch{2}.spm.stats.fmri_spec.sess.multi_reg = {multi_reg};
matlabbatch{2}.spm.stats.fmri_spec.sess.hpf = 128;
matlabbatch{2}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{2}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{2}.spm.stats.fmri_spec.volt = 1;
matlabbatch{2}.spm.stats.fmri_spec.global = 'None';
matlabbatch{2}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{2}.spm.stats.fmri_spec.mask = {''};
matlabbatch{2}.spm.stats.fmri_spec.cvi = 'AR(1)';
matlabbatch{3}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{3}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{3}.spm.stats.fmri_est.method.Classical = 1;
matlabbatch{4}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{4}.spm.stats.con.consess{1}.tcon.name = 'Mechanical Stimulation';
matlabbatch{4}.spm.stats.con.consess{1}.tcon.weights = [1 0];
matlabbatch{4}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
matlabbatch{4}.spm.stats.con.delete = 0;
matlabbatch{5}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {folderpath};
matlabbatch{5}.cfg_basicio.file_dir.file_ops.file_fplist.filter = 'mean.*';
matlabbatch{5}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';
matlabbatch{6}.spm.stats.results.spmmat(1) = cfg_dep('Contrast Manager: SPM.mat File', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{6}.spm.stats.results.conspec.titlestr = '';
matlabbatch{6}.spm.stats.results.conspec.contrasts = 1;
matlabbatch{6}.spm.stats.results.conspec.threshdesc = 'none';
matlabbatch{6}.spm.stats.results.conspec.thresh = 0.05;
matlabbatch{6}.spm.stats.results.conspec.extent = 5;
matlabbatch{6}.spm.stats.results.conspec.conjunction = 1;
matlabbatch{6}.spm.stats.results.conspec.mask.none = 1;
matlabbatch{6}.spm.stats.results.units = 1;
matlabbatch{6}.spm.stats.results.export{1}.ps = true;
matlabbatch{6}.spm.stats.results.export{2}.montage.background(1) = cfg_dep('File Selector (Batch Mode): Selected Files (mean.*)', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{6}.spm.stats.results.export{2}.montage.orientation = 'axial';
matlabbatch{6}.spm.stats.results.export{2}.montage.slices = [0 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85];
matlabbatch{6}.spm.stats.results.export{3}.binary.basename = 'clusters';
matlabbatch{7}.spm.util.print.fname = '';
matlabbatch{7}.spm.util.print.fig.figname = 'Graphics';
matlabbatch{7}.spm.util.print.opts = 'jpg';
matlabbatch{8}.spm.util.print.fname = '';
matlabbatch{8}.spm.util.print.fig.figname = 'SliceOverlay';
matlabbatch{8}.spm.util.print.opts = 'jpg';

%%
spm_jobman('run', matlabbatch);
