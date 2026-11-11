# SPM12 preprocessing and 1st level analysis of mouse task fMRI data

MATLAB scripts we used to preprocess and analyse the task fMRI data of

> Chen H-F, Segelcke D, Bhatti HA, Chao H-Y, Nagelmann N, Sandbrink M, Kreitz S,
> Hess A, Faber C, Pogatzki-Zahn E, Pradier B (2026). *Sex-Specific Central
> Encoding of Pain Hypersensitivity and Recovery Revealed by fMRI in a Mouse
> Model of incisional Pain.* Imaging Neuroscience.
> [doi:10.1162/IMAG.a.1393](https://doi.org/10.1162/IMAG.a.1393)

If you use this code, please cite this article.

DICOM files go in; a smoothed 4D NIfTI file and the 1st level result (GLM with
the mouse HRF) come out. Registration to the atlas (MagnAn), group statistics
and connectivity are not included.

Hui-Fen Chen & Bruno Pradier, University of Münster

## What you need

- MATLAB with [SPM12](https://www.fil.ion.ucl.ac.uk/spm/software/spm12/) (we used SPM12 r7771)
- Windows (the scripts use `\` in paths)

[dcm2niix](https://github.com/rordenlab/dcm2niix) for Windows (v1.0.20261029,
with the Microsoft C++ runtime files it needs) is included in the folder
`dcm2niix`; see `dcm2niix\license.txt` for its license. For the paper we used
the dcm2niix version that came with MRIcroGL at the time (2021/2022).

## How to run

1. Put the path to SPM12 in `A_settings.m`.
2. Run the scripts one after the other:

| Script                                    | What it does                                                         | SPM batch                                                                |
|-------------------------------------------|----------------------------------------------------------------------|--------------------------------------------------------------------------|
| `aa_data_conversion.m`                    | DICOM → `.nii.gz`                                                    | `batches\runGL_dcm2niix.m`                                               |
| `bb_UKM_Incision_Study_4Dto3D.m`          | 4D → 3D, deletes the first 20 repetitions                            | `batches\SPM_4Dto3D.m`                                                   |
| `cc_UKM_Incision_Study_preprocessing.m`   | voxel size ×10, slice timing, realignment, smoothing                 | `batches\SPM_preprocessing_srav.m`                                       |
| `dd_UKM_Incision_Study_3Dto4DandDelete.m` | 3D → 4D, deletes the 3D files except the smoothed ones               | `batches\SPM_3Dto4DandDelete.m`                                          |
| `ee_UKM_Incision_Study_1stLevel.m`        | 1st level GLM with the mouse HRF, then deletes the smoothed 3D files | `batches\SPM_post_1stOrder.m`, `batches\SPM_export_statistics_results.m` |

Or all at once: in MATLAB `run_all` (or `run_all({'cc','dd','ee'})` for some
steps only), or from PowerShell in this folder:

```powershell
& "C:\Program Files\MATLAB\R2023a\bin\matlab.exe" -sd "$PWD" -wait -nodesktop -nosplash -logfile run_all_log.txt -r "try, run_all; catch e, disp(getReport(e)); exit(1); end; exit(0)"
```

The output of MATLAB is written to `run_all_log.txt`; `$LASTEXITCODE` is 1 if
a step failed.

The DICOM files are expected in `test_data\<session>\<scan>\` or zipped as
`test_data\<session>\<scan>.zip`. Each scan gets its own folder
`test_output\<session>_<scan>\`.

## Test data

`test_data` contains the zipped DICOM files of two task scans
(`20220201b\E13.zip`, `20220201c\E12.zip`). Running `aa_` to `ee_` without
changes (apart from the paths in `A_settings.m`) processes them.

## Output (per scan)

- `sra<scan>.nii` – the final file: slice timing, realignment, smoothing (600 repetitions)
- `ra<scan>.nii`, `a<scan>.nii`, `v<scan>.nii` – the steps before
- `rp_av<scan>_00021.txt` – realignment parameters (regressors in the GLM, motion QC)
- `meanav<scan>_00021.nii` – mean image of the realignment
- `realignment*.png` – SPM realignment plot
- `1stLevel_mouseHRF\` – `SPM.mat`, `spmT_0001.nii`, `clusters.nii` (binary map of the activated voxels), `statistics.xls`, SPM figures

## Parameters

Preprocessing (`batches\SPM_preprocessing_srav.m`):

- voxel size ×10, so that SPM's defaults (made for human brains) work for the mouse brain; 200×200×500 µm voxels become 2×2×5 mm, all values below are in these units
- slice timing: 18 slices, TR 1 s, TA 0.944 s, slices 1–18 ascending, reference slice 9
- realignment: quality 0.9, separation 5, FWHM 0, register to mean, reslice with 4th-degree B-spline
- smoothing: Gaussian kernel [4 4 10] = 2 voxels in each direction

Each scan had 620 repetitions; the first 20 are removed. For scans recorded as
one 1220-repetition series only repetitions 21–620 are used.

1st level (`batches\SPM_post_1stOrder.m`):

- block design: 20 blocks, onsets 11, 41, ..., 581 s, 10 s stimulation each
- mouse HRF (Chen et al. 2023, Front Neurosci), no derivatives: `[4.95 8.69 1.1 1.1 1.8 0 32]` (parameters of `spm_hrf.m`, set in `A_settings.m`)
- the 6 realignment parameters as regressors, high-pass filter 128 s, AR(1)
- t contrast `[1 0]`, threshold p < 0.05 uncorrected, cluster size ≥ 5 voxels

## What we changed compared to the scripts used for the paper

Fixed paths and index ranges (`for a = 162:...`) were replaced by
`A_settings.m` and loops over the folders, files are found by name patterns,
and the raw data are not moved or deleted anymore. The mouse HRF is set with
`spm_get_defaults` instead of renaming `spm_my_defaults.m` files in the SPM
folder. The SPM batches and their parameters are unchanged.

## License

MIT, see `LICENSE`.

Questions: bruno.pradier@uni-muenster.de