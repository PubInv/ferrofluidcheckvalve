# A Passive Ferrofluid Check Valve (PFCV)
This repo describes a *passive* ferrofluid one-way valve.
This invention is apparently novel and should be quite important for making it 
easier to fabricate lab-on-a-chip applications, because it has no moving parts,
and is completely passive.

# Progress as of 13 July 2024

Last night, Joe Hershberge and proved out our best valve design yet. We are 
now consistently getting a collapse pressure of more than 100 cm of water, 
and cracking pressure of less than 10 cm of water.
This is the best ratio we have measured. 
This design used a 3D chamber,
which was a recommendation that Joe made. 

![IMG_5257 (1)](https://github.com/user-attachments/assets/12c9c470-a207-405e-9202-e67b099f0d78)

Note, in the data below, we used a high-pressure manometer with a resolution of only 4 cmH2O;
we have a more precise low-pressure one, which we will use in the next experiments.
| Trail Name  | Cracking (cmH2O)  | Collapse (cmH2O)  |  Comment |   |
|---|---|---|---|---|
| X1  | 8 | 114  |   |   |
| X2  | 8  | 110   |   |   |
| X3  | 8  | 110  |   |   |
| X4  | 12  |  106 |   | 2" magnet instead of 1"  |
| X5  |  8 |  110 |   | System held upside down in same configuration  |
		


# A Humorous History
Our previous attempts to do this were deeply flawed (see below).

When public invention volunteer Veronica Stuckey agreed to work on this project, 
she invigorated the design effort. I wrote a quick (3-day) simulation using particles
in a magnetic field, which gave me some rough guidance. This allowed
me to design an asymmetric chamber which I thought might work. 
Veronica immediately tested it, and it worked---but in the opposite direction from the
way that I thought it would work!
That is, my theory of why the inlet would have low cracking pressure and the outlet 
sustain high pressure was completely and perfectly backwards. However, this meant
that despite this error, we had succeeded in creating a functional ferrofluid valve
with no moving parts!
-- Robert L. Read

# The Successful Valve

The current valve is described in [the paper](https://github.com/PubInv/ferrofluidcheckvalve/blob/master/doc/journal-1.2/asme2ej.pdf) in this repo that we will
submit to an open access journal soon. Like all Public Invention inventions, we do not seek patents, and you are free to use this design under the CERN Strong Reciprocal License [(CERN-OHL-S-2.0)](https://ohwr.org/cern_ohl_s_v2.txt). 

The gist of the fundamental invention can be understood from the this diagram:
![TopViewFerrofluidModelLabelled](https://user-images.githubusercontent.com/5296671/143282739-8558cb70-b031-4ace-9674-54a213ffebf4.png)

Veronica Stuckey made a [nice video](https://www.youtube.com/watch?v=IGzz6LX1n6A) of her work that explains it well.

![Screen Shot 2021-11-24 at 11 06 02 AM](https://user-images.githubusercontent.com/5296671/143283489-8d207dbe-410a-497d-abb8-928db957d92e.png)

# Design For a Piston to Make a Pump

One of the most interesting things to do with these valves are to use them to make a pump. A pump simply requires a change in volume in the 
pumped fluid between two valves allowing flow in the same direction. We demonstrate this with our existing appratus via a hand-pumped syringe.
However, we could also use a ferrofluid piston, in which case we would have a pump with no moving parts except for ferrfoluid itself.

A piston may be made by moving a blob of ferrofluid in channel (this has been done by many researchers already.) Based on some initial
experiments, here is our design for an electronic ferrofluid piston:

![Pump Improvements](https://user-images.githubusercontent.com/5296671/222033199-69d51536-0f8e-49c7-8b1f-76b9fa031a20.png)


# Initial (Wrong Polarity) Sketch Idea

NOTE: as mentioned before, this idea is wrong, but usefully wrong---the valve works in the opposite direction to what is suggested.

![Ferrofluid Check Valve Idea #2](https://user-images.githubusercontent.com/5296671/132899305-987c92eb-7473-424c-9d72-bdc92220f689.png)

# Future Steps

As always, Public Invention invites you take this idea and run with it! Some potential fun things to do next would be:
1. Can the performance of the valve be improved by shaping the chamber and/or the magnetic field better?
2. How do the pressures change if you scale it down?
3. How far can it be scaled down with a 3D printer before some sort of lithographic or etching technique is required?
4. Can you make a positive-displacement pump on a single unit by making a 3D printed pump consiting of a 2 PFCVS, a piston made out of a ferrofluid bolus, and an external electomagnet to move the piston (possibly on a PCB)?
5. This design is essentially a 2D shape slightly extrudede to be a 3D volume. Is there a fully 3D design that is similar but would have better performance?



# Previously (2019)
An attempt to build a ferrofluidcheckvalve

This project is now considered a failure; I've attempted to write up what was learned, which is [published](https://medium.com/@RobertLeeRead/failed-experiments-with-ferrofluid-742fa13b0ae1) at Medium

# References

Note: The academic paper herein contains a better list of references!

[Micromachines | Free Full-Text | Magnetically Induced Flow Focusing of Non-Magnetic Microparticles in Ferrofluids under Inclined Magnetic Fields | HTML (mdpi.com)](https://www.mdpi.com/2072-666X/10/1/56/htm)

[Ferrofluidic Pumps: A Valuable Implementation Without Moving Parts | IEEE Journals & Magazine | IEEE Xplore](https://ieeexplore.ieee.org/abstract/document/5196729/citations?tabFilter=patents#anchor-patent-citations)

[Modeling of ferrofluid magnetic actuation with dynamic magnetic fields in small channels | SpringerLink](https://link.springer.com/article/10.1007/s10404-014-1442-7)
(This paper was the one talking about the rotating magnets, however, this was all done in COMSOL simulation)

[Development of a novel electromagnetic pump for biomedical applications - ScienceDirect](https://www.sciencedirect.com/science/article/abs/pii/S092442471000049X)

[Magnets & Magnetism Frequently Asked Questions | Magnet FAQs (intemag.com)](https://www.intemag.com/magnetic-frequently-asked-questions)
(This site I referenced because of the portion the talks about how a magnet's strength drops off over distance, and gives a good overview on magnetic behavior for the uninitiated)

[On demand manipulation of ferrofluid droplets by magnetic fields - ScienceDirect](https://www.sciencedirect.com/science/article/abs/pii/S092540051631913X)
(Ferrofluid behavior with magnets, not specific)
