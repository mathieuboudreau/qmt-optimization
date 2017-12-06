# Quantitative Magnetization Transfer MRI Optimization Toolbox

qmt-optimization is a qMT acquisition design optimization toolbox that wraps around [qMRLab](https://github.com/neuropoly/qMRLab).
This toolbox uses an iterative reduction optimization algorithm to optimize the acquisition protocols for spoiled gradient echo qMT
sensitivity against noise (using the Cramér-Rao lower bound) and also sensitivity-regularization for robustness of a qMT
parameter-of-interest against inaccuracies in the additional measurements required for qMT (e.g. B<sub>1</sub>).
Currently, sensitivity-regularized optimization mode is only available for the pool-size ratio (F) sensitivity against B<sub>1</sub>-inaccuracies 
- read the class documentation for more details.

## Getting Started

After [installation](#Installation), the next step should be to run all automated software tests to ensure 
that the software is working as expected. Details on how to run Matlab's testing framework 
for this toolbox are described in the [tests](#Tests) section below.

Several demos are included in this package, and are located in the [demo/](https://github.com/mathieuboudreau/qmt-optimization/blob/master/demo/) 
folder. New usersare recommended to read and run these demos for guidance on how to use the software. We 
recommended that these demos are explored in the following order, which follows the 
typical usage pattern:

1. [demo\_jacobian\_computation.m](https://github.com/mathieuboudreau/qmt-optimization/blob/master/demo/demo_jacobian_computation.m)
2. [demo\_optimization.m](https://github.com/mathieuboudreau/qmt-optimization/blob/master/demo/demo_optimization.m)
3. [demo\_montecarlo\_simulation.m](https://github.com/mathieuboudreau/qmt-optimization/blob/master/demo/demo_montecarlo_simulation.m)

Some features may require knowledge of qMRLab GUI features (e.g. setting up and saving a protocol, or caching the Sf table).
For details on how to use qMRLab, read the documentation included in the submodule's folder or the (more up-to-date) qMRLab repository [here](https://github.com/neuropoly/qMRLab).

## Installation

All you need is a supported version of MATLAB installed, no additional software is required. 

After installation, we strongly recommend that you run all tests in this repository (see Test section below) to ensure correct installation and code compatibility with your operating system and Matlab version.

### Command-Line Instructions

If you have git available on a command-line interface (e.g. Terminal on Mac OSX, Git Shell on Windows), the installation can be completed using a few quick commands.

* In the command-line interface, navigate (`cd`) to the directory that you want to install qMTLab_Tab1s.

* Clone the directory:

`git clone https://github.com/mathieuboudreau/qmt-optimization.git`

* Change directory to the cloned repo: `cd qmt-optimization`

* Install the submodule(s): `git submodule update --init`

### Zip Download Instructions

The latest stable version of qmt-optimization can be downloaded freely [here](https://github.com/mathieuboudreau/qmt-optimization/tarball/master).

* Extract the downloaded file to the directory you want to install qmt-optimization.

* Rename the folder to *qmt-optimization*.

* Download the suggested (stable) qMRLab submodule version [here](https://github.com/mathieuboudreau/qMRLab/tarball/bba9fb2bd2b2145c2dfe4b1e550b7dc02091cfe3)

* Extract the downloaded file to a temporary location - *not the qmt-optimization repository.*

* Copy or cut the **contents** of the extracted directory into the folder *qmt-optimization/qMRLab/*

### Windows/Mac line endings Git compatibility fix

The code was mostly developed using a Mac OSX system. In my experience, when first using this repo in Windows, Git was throwing `LF will be replaced by CRLF` warnings, due to how Windows and Mac deal differently with line endings.

To resolve this, I suggest you:

*  Delete your installed qmt-optimization repository

* In the command line, run `git config --global core.autocrlf false`

* Reinstall qmt-optimization

## Supported MATLAB versions

This software has been tested and is known to work with the following versions:

* R2017a (64-bit)

## Tests

After installing the software, we suggest that the you evaluate all the test cases for the software. If all tests pass, then
your MATLAB version should be compatible and the software will have completely installed correctly. 

### Run all tests

Running all tests is a time consuming and processor-intensive process. On a standard MacBook pro, this can take 20 to 30 minutes
minutes. You should only need to do this after a fresh install of the software, after updating your MATLAB version, or if an 
unknown error occurred during your workflow.

To run all tests, from MATLAB (assuming you are already in the qMTLab_Tab1s directory), go to the 'test' subfolder

`cd test/`

and execute the following command.

`result = runtests(pwd, 'Recursively', true)`

Any failed test should be resolved prior to starting a workflow. Users are invited to raise the issue on the GitHub
repository: https://github.com/mathieuboudreau/qMTLab_Tab1s/issues

### Run Test Suite

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

## Contributing

Please report any bugs or suggest new features by opening a [GitHub issue](https://github.com/mathieuboudreau/qmt-optimization/issues).

## About Me

**Mathieu Boudreau** is a PhD Candidate at McGill University in the Department of Biomedical Engineering. He holds a BSc in 
Physics from the Université de Moncton ('09), and an MSc in Physics from the University of Western Ontario ('11)
