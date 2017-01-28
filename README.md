# qMTLab Tab<sub>1</sub>s

qMTLab Tab<sub>1</sub>s (opTimizAtion for B<sub>1</sub> inSensitivity) 

It is an extension of qMTLab, a powerful, open source, scalable, easy to use and intuitive software for qMTI data simulation, fitting and analysis. The software consists of two parts:
1) a qMT data simulator
2) a qMT data fitting and visualization interface

qMTLab Tab<sub>1</sub>s extends the functionality to optimize the acquisition protocols of various qMT techniques to minimize
sensitivity against noise (using Fisher Information minimizations) as well as B<sub>1</sub>-sensitivity for chosen
parameters-of-interest.

## Documentation

For a quick introduction to qMTLab functionnalities, see the [qMTLab PowerPoint e-poster](https://github.com/neuropoly/qMTLab/raw/master/qMTLab-Presentation.ppsx) which was presented at the 2016 ISMRM conference. You can also watch the presentation on [YouTube](https://youtu.be/WG0tVe-SFww).

For more in-detail explanations, please read the ['ReadMe.docx'](https://github.com/neuropoly/qMTLab/raw/master/ReadMe.docx).

qMTLab was published in Concepts in Magnetic Resonance Part A: [*Quantitative magnetization transfer imaging made easy with qMTLab: Software for data simulation, analysis, and visualization*](http://onlinelibrary.wiley.com/doi/10.1002/cmr.a.21357/abstract)

## Installation

Installing qMTLab Tab<1>s is easy and hassle-free! All you need is a supported version of MATLAB installed, no additional 
software is required. 

The latest stable version of qMTLab Tab<sub>1</sub>s can be downloaded freely [here](https://github.com/mathieuboudreau/qMTLab_Tabs/tarball/master).

* Alternatively, you can clone the git repository from GitHub using this link: `https://github.com/mathieuboudreau/qMTLab_Tabs.git` 

* If you have a GitHub account (free) and wish to contribute to the software, you can go to [https://github.com/neuropoly/qMTLab](https://github.com/neuropoly/qMTLab) and fork the repository to your account. If you make any contribution to the software that you feel should be included in the project, please make a pull request so that we can review your modifications before including them in the project.

Once you have downloaded and extract the *.zip file or cloned the repository, start MATLAB, navigate to the qMTLab folder, and in the Command Window type `qMTLab` and hit enter. After a few seconds of loading, you should be presented with a graphical user interface (GUI) and you're ready to start simulating or processing qMT data!

## Supported MATLAB versions

This software has been tested and is known to work with the following versions:

* R2015b (64-bit)

If you experience any compatibility issues, please report them through [GitHub](https://github.com/neuropoly/qMTLab/issues).

## Tests

After installing the software, we suggest that the you evaluate all the test cases for the software. If all tests pass, then
your MATLAB version should be compatible and the software will have completely installed correctly. 

# Run all tests

Running all tests is a time consuming and processor-intensive process. On a stock MacBook pro, this can take up to 20 
minutes. You should only need to do this after a fresh install of the software, after updating your MATLAB version, or if an 
unknown error occurred during your workflow.

To run all tests, go to the 'test' subfolder

`cd test/`

and execute the following command.

`result = runtests(pwd, 'Recursively', true)`

Any failed test should be resolved prior to starting a workflow. Users are invited to raise the issue on the GitHub
repository: https://github.com/mathieuboudreau/qMTLab_Tab1s/issues

# Run Test Suite

During development of new features or bug-fixing, it will be preferable to run a test suite relevant to a specific category.
To do so, go to the 'test' folder

`cd test/`

and run the following command:

`result = runTestSuite('Tag')`

substituting `Tag` for one of the following test tags. If you develop new tests and give it a tag which isn't on this list,
please update the README.md file accordingly.

Test tags:

* Unit

* Integration

* Demo

* SPGR

* VFA

* Sensitivity

## Data Format

## To-Do

### Development Branch

* Extend Sensitivity Calculation for B1 variations (constant T1)

* Add T1 signal generation

* Add T1 fitting

* Extend Sensitivity Calculation for B1 variations (VFA T1)

### Optimization Branch

* Implement Sensitivity Analysis metrics calculations

* Write algorithm that takes a 2xN array argument (values, zSpectrumID; cell array) identifies the index of the largest (smallest?) value

* Write function that will take the index to be removed, store it in a list variable (to keep track when each point was removed), 

### Analysis Branch

* Create 2D Shepp-Logan phantom generator for specific tissue tags

* Convert extra high res shepp-logan phantom to imaging resolution, to investigate multi-tissue voxel impact

* Function that takes Shepp-Logan phantom and qMT protocol as args, and outputs the ideal qMT measured values.

* Function that takes ideal qMT Shepp-Logan set and noise level, and adds noise to images.

* qMT data fitting framework integration with qMTLab

* Script to investigate B1 errors varying homogeneously %-wise for scaled values (1%, 5%, 10%, 25%), or higher res?

* Script to investigate Nominal Flip Angle assumption on qMT.


## Contributing

Please report any bugs or suggest new features through [GitHub](https://github.com/mathieuboudreau/qMTLab_Tabs/issues).

## Citation

If you use qMTLab in you work, please cite:

Cabana, J.-F., Gu, Y., Boudreau, M., Levesque, I. R., Atchia, Y., Sled, J. G., Narayanan, S., Arnold, D. L., Pike, G. B., Cohen-Adad, J., Duval, T., Vuong, M.-T. and Stikov, N. (2015), _Quantitative magnetization transfer imaging made easy with qMTLab: Software for data simulation, analysis, and visualization_. Concepts Magn. Reson., 44A: 263–277. doi: 10.1002/cmr.a.21357

## About Me

**Mathieu Boudreau** is a PhD Candidate at McGill University in the Department of Biomedical Engineering. He holds a BSc in 
Physics from the Universite de Moncton ('09), and a MSc in Physics from the University of Western Ontario ('11).

## About NeuroPoly

**NeuroPoly** is a research laboratory specialized in neuroimaging. It is based at [École Polytechnique](http://www.polymtl.ca) on the [Université de Montréal](http://www.umontreal.ca) campus, in Montréal, Canada.
