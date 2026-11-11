function runGL_dcm2niix(glExe, output_filename, input_path, output_path)
% converts the DICOM files in input_path with dcm2niix (MRIcroGL)
% glExe: path of dcm2niix.exe
% Hui-Fen Chen, University of Muenster

%C:\MRIcroGL\Resources\dcm2niix.exe -f "27" -i y -l y -p y -x y -v y -z y "C:\Users\...\27-1"
cmd = ['"',glExe,'" -f "',num2str(output_filename),'" -i y -l y -p y -x y -v y -z i -o "',output_path,'" "',input_path,'"']
% idealy, should use '-z y' but need to use '-z i' for compressed nifti file.
status = system(cmd);
if status ~= 0
    error('dcm2niix failed for %s (exit code %d)', input_path, status);
end
