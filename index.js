
// const { program } = require('commander');


const { Command } = require('commander');
const program = new Command();
const chalkAnimation = require('chald-animation');

chalkAnimation.rainbow('Linix Init - Version 0.1.1');
program.version('0.0.1');

program
	.options('-v, --version'), 'Print program version and exit.');



program.parse(process.argv);

const options = program.opts();
	// if (options.verbosity) console.log(option) 
