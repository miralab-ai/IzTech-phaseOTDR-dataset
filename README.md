# IzTech-phaseOTDR-dataset
Dataset for the article below:  

"An Intensity and Phase Stacked Analysis of Φ-OTDR System using Deep Transfer Learning and Recurrent Neural Networks"

Ceyhun Efe Kayan, Kivilcim Yuksel Aldogan, and Abdurrahman Gumus, “Intensity and phase stacked analysis of a Φ-OTDR system using deep transfer learning and recurrent neural networks,” Applied Optics 62, 1753-1764 (2023) [(link to paper)](https://opg.optica.org/ao/abstract.cfm?uri=ao-62-7-1753) 

## Dataset: 
includes Raw Data files for 15 different cases presented in the article. 

https://drive.google.com/drive/folders/1U_fTdhzhofmb6wNdpwNNhbNoScKgNt21?usp=sharing 

## File name format:
[Date]_[Apzt]V_[fvib]Hz.mat

**Example:** the phase-OTDR traces for vibration amplitude of 3 V (A<sub>pzt</sub>=3 V) and vibration frequency of 500 Hz (f<sub>vib</sub>=500 Hz) is recorded as _08Sept2017_1V_500Hz.mat_.

**Date:** 08Sept2017 for all 15 files (the date of the measurements).

## Reading Raw Data (main.m) : 

Using main.m, one can plot the Phase-OTDR traces by extracting the data from the *.mat file and placing it as rows in a matrix (tracematrix).

→Just needed to change the filename (example: trname='08Sept2017_2V_500Hz')

In this way, rows in the matrix represent the spatial distribution, and each column presents the variation of the trace at a particular position during the slow-time window. Then, A bandpass filtering is applied for collecting the frequency components centered around the pulse modulator’s frequency shift (an acousto-optic modulator was used in the set up imposing a frequency shift of 𝐹<sub>𝐴𝑂𝑀</sub> = 160 MHz (the filter can be implemented by various ways).

## Preprocessing:

The following procedures are implemented on tracematrix to obtain the final temporal-spatial matrice:
* Each term in a Φ-OTDR trace is converted into a complex number by applying the Hilbert transform.
* By using the magnitude operation, the amplitude matrix is obtained.
* To obtain the phase matrix, the phase shift of the acousto-optic modulator is subtracted from the angle of each complex term.
* The differential amplitude matrix is obtained by subtracting the first row of the amplitude matrix from the other columns.
* The first column of the phase matrix is subtracted from other columns to remove the “initial phase” caused by the laser source.
* The mode of each term in the phase matrix with 2𝜋 is calculated (not included in the main.m)





## Citation 
If you use the IzTech-phaseOTDR-dataset in your research, please cite our related publication: 

```bibtex
@article{kayan2023intensity,
  title={Intensity and phase stacked analysis of a $\Phi$-OTDR system using deep transfer learning and recurrent neural networks},
  author={Kayan, Ceyhun Efe and Aldogan, Kivilcim Yuksel and Gumus, Abdurrahman},
  journal={Applied Optics},
  volume={62},
  number={7},
  pages={1753--1764},
  year={2023},
  publisher={Optica Publishing Group}
}
