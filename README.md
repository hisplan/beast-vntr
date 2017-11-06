# BEAST2 & BEASTvntr

Bayesian phylogenetic analysis of molecular sequences and VNTR or Microsatellites

- beagle-lib v2.1.2
- BEAST v2.4.7
- BEASTvntr v0.1.1

## Building Docker BEAST2 and BEASTvntr

```
$ docker build -t my-beast-vntr .
```

## Running GUI applications using Docker for Mac

### Installing XQuarts

https://www.xquartz.org/

You might have to reboot your computer.

### Configuring XQuarts

Start XQuartz from command line using:

```
$ open -a XQuartz
```

In the XQuartz preferences, go to the `Preferences` menu, then the `Security` tab, and enable `Allow connections from network clients`.

Run the following:

```
$ IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
$ xhost + $IP
```

You should be seeing something like:

```
w.x.y.z being added to access control list
```

where `w.x.y.z` is your IP address.

## Running BEASTvntr

```
$ docker run -it -e DISPLAY=$IP:0 my-beast-vntr
```

## Known Issues

Running `BEAUti` throws the null pointer exception shown below:

```
java.lang.NullPointerException
	at beast.app.beastapp.BeastLauncher.copyFilesInDir(Unknown Source)
	at beast.app.beastapp.BeastLauncher.createBeastPackage(Unknown Source)
	at beast.app.beastapp.BeastLauncher.loadBEASTJars(Unknown Source)
	at beast.app.beauti.BeautiLauncher.main(Unknown Source)
```

## References

- http://www.beast2.org/
- http://beast.community/
- https://github.com/CompEvol/beast2
- https://github.com/beagle-dev/beagle-lib
- https://github.com/arjun-1/BEASTvntr
