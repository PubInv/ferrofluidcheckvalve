# A Passive Ferrofluid Check Valve
This repo describes a *passive* ferrofluid one-way valve.
This invention is apparently novel and should be quite important for making it 
easier to fabricate lab-on-a-chip applications, because it has no moving parts,
and is completely passive.

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

The current valve is describe in [the paper](https://github.com/PubInv/ferrofluidcheckvalve/blob/master/doc/journal-1.2/asme2ej.pdf) in this repo that we will
submit to an open access journal soon. Like all Public Invention inventions, we do not seek patents, and you are free to use this design under the CERN Strong Reciprocal License [(CERN-OHL-S-2.0)](https://ohwr.org/cern_ohl_s_v2.txt). 

The gist of the fundamental invention can be understood from the this diagram:
![TopViewFerrofluidModelLabelled](https://user-images.githubusercontent.com/5296671/143282739-8558cb70-b031-4ace-9674-54a213ffebf4.png)

Veronica Stuckey made a [nice video](https://www.youtube.com/watch?v=IGzz6LX1n6A) of her work that explains it well.





# Initial Sketch Idea

NOTE: as mentioned before, this idea is wrong, but usefully wrong---the valve works in the opposite direction to what is suggested.

![Ferrofluid Check Valve Idea #2](https://user-images.githubusercontent.com/5296671/132899305-987c92eb-7473-424c-9d72-bdc92220f689.png)



# Previously (2019)
An attempt to build a ferrofluidcheckvalve

This project is now considered a failure; I've attempted to write up what was learned, which is [published](https://medium.com/@RobertLeeRead/failed-experiments-with-ferrofluid-742fa13b0ae1) at Medium

# References

[Micromachines | Free Full-Text | Magnetically Induced Flow Focusing of Non-Magnetic Microparticles in Ferrofluids under Inclined Magnetic Fields | HTML (mdpi.com)](https://www.mdpi.com/2072-666X/10/1/56/htm)

[Ferrofluidic Pumps: A Valuable Implementation Without Moving Parts | IEEE Journals & Magazine | IEEE Xplore](https://ieeexplore.ieee.org/abstract/document/5196729/citations?tabFilter=patents#anchor-patent-citations)

[Modeling of ferrofluid magnetic actuation with dynamic magnetic fields in small channels | SpringerLink](https://link.springer.com/article/10.1007/s10404-014-1442-7)
(This paper was the one talking about the rotating magnets, however, this was all done in COMSOL simulation)

[Development of a novel electromagnetic pump for biomedical applications - ScienceDirect](https://www.sciencedirect.com/science/article/abs/pii/S092442471000049X)

[Magnets & Magnetism Frequently Asked Questions | Magnet FAQs (intemag.com)](https://www.intemag.com/magnetic-frequently-asked-questions)
(This site I referenced because of the portion the talks about how a magnet's strength drops off over distance, and gives a good overview on magnetic behavior for the uninitiated)

[On demand manipulation of ferrofluid droplets by magnetic fields - ScienceDirect](https://www.sciencedirect.com/science/article/abs/pii/S092540051631913X)
(Ferrofluid behavior with magnets, not specific)
