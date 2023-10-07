const { exec } = require('child_process');
const chalk = require('chalk');

function queryInstalledExtensions() {
    const command = 'ls system extensions';

    exec(command, (error, stdout, stderr) => {
        if (error) {
            console.error(chalk.red('Error:', error.message));
            return;
        }

        if (stderr) {
            console.error(chalk.yellow('Warning:', stderr));
        }

        console.log(chalk.green('Installed Extensions:'));
        console.log(stdout);
    });
}

queryInstalledExtensions();