# TGDOF
 This is the testing code of TGDOF for CS-MRI.

Running the script  "AddPath" and then the "Demo_TGDOF" to test the basic deep framework for CS-MRI.


TestData
------------
The testing MR slices used in experiments, including 25 T1-weighted data and 25 T2-weighted data.
The slices are extracted from the subset of the IXI datasets: http://brain-development.org/ixi-dataset/

ArtifactsModel
------------
The pre-trained model used in Module \mathcal{N}.

SamplingPatter:
------------
The three kinds of sampling patterns at five different sampling ratios (10% to 50%). 


If you utilize this code, please cite the related paper: <br>
@inproceedings{liu2019theoretically,<br>
   title={A theoretically guaranteed deep optimization framework for robust compressive sensing mri},<br>
   author={Liu, Risheng and Zhang, Yuxi and Cheng, Shichao and Fan, Xin and Luo, Zhongxuan},<br>
   booktitle={Proceedings of the AAAI Conference on Artificial Intelligence},<br>
   volume={33},<br>
   pages={4368--4375},<br>
   year={2019}
 }
