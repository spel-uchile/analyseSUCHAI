public
produceVisualization
	"SUCHAI 2"

	"The following code shows dependencies between "

	| root p b allSystemModules allDrivers relevantModules |
	root := self pathToSourceCode.
	p := CPPProcessor new.
	p processRootFolder: root asFileReference.
	p resolveDependencies.
	allSystemModules := p modules
		select: [ :m | '*/system/*' match: m filename ].
	allDrivers := p modules
		select: [ :m | '*/drivers/Linux/*' match: m filename ].
	relevantModules := allSystemModules , allDrivers.
	relevantModules := relevantModules
		reject: [ :m | '*/libcsp/libcsp/*' match: m filename ].
	b := RTMondrian new.
	b shape rectangle
		color: Color darkGray;
		if: [ :f | '*/cmd*' match: f filename ] color: Color blue;
		if: [ :f | '*/task*' match: f filename ] color: Color green;
		if: [ :f | '*/drivers/*' match: f filename ] color: Color lightGray;
		if: [ :f | '*repo*' match: f filename ] color: Color red.
	b interaction
		highlightNeighbour: #dependentModules
		color: Color orange.
	b nodes: relevantModules.
	b shape arrowedLine
		withOffset;
		color: Color blue trans;
		width: 0.2.
	b edges
		moveBehind;
		connectToAll: #dependentModules.
	b layout sugiyama
		verticalGap: 20;
		horizontalGap: 10.
	b normalizer normalizeSize: #loc.
	b build.
	self addLegendTo: b view.
	^ b view