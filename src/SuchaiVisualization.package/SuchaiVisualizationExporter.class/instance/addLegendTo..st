private - utility
addLegendTo: aview
	| lb |
	lb := RTLegendBuilder new.
	lb setAsFixed.
	lb view: aview view.
	lb addText: 'Dependencies between modules'.
	lb addColor: Color blue text: 'Command'.
	lb addColor: Color lightGray text: 'Driver'.
	lb addColor: Color green text: 'Task'.
	lb addColor: Color red text: 'Repository'.
	lb build