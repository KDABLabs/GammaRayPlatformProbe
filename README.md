# GammaRay Platform Probe

This is a small application that does nothing but starting a GammaRay probe that
you can connect to with the GammaRay client over the network.

This is only useful for inspecting how a Qt application in general sees things on a specific
device, or what a device offers in general, not for debugging a specific Qt application.
For that you need to inject the GammaRay probe into your own application.

The GammaRay Platform Probe can be interesting when working on platform infrastructure,
or when working with more closed devices such as e.g. Android, before working application
code is available.

However, you are most likely looking for https://github.com/KDAB/GammaRay rather than this.
