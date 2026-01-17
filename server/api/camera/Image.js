const util = require('util');
const exec_cb = require('child_process').exec;
const exec = util.promisify(exec_cb);
const fs = require('fs/promises');
const path = require('path');


class Image {
    constructor() {
        this.name = "camera.Image";
        this.target_directory = `${process.env.SUPER_DUPER_PI_SURVELIANCE_ROOT}/scripts/camera`;
    }

    log(message) {
        console.log(`[${this.name}] ${message}`);
    }

    async do() {
        this.log(`do() {`)
        let result;
        try {
            const cmd = `./image.sh`;
            let {stdout, stderr} = await exec(cmd, {cwd: this.target_directory});
            result = [stdout, stderr];
        } catch (error) {
            throw error;
        }
        this.log(`} do()`)
        return result[0];
    }
}


class Get {
    constructor(app) {
        this.name = "camera.Image.Get";
        this.image = new Image();
        app.get('/camera/api/image', async (req, res) => {
            try {
                const image = await this.image.do();
                const lines = image.split('\n');
                let destination;
                lines.forEach((line, index)=>{
                    if (line.length>0 && index == lines.length-2) {
                        const pairs = line.split(',');
                        const camera_index = '0';
                        const destination_pair = pairs[1];
                        const destination_value = destination_pair.split(':');
                        destination = destination_value[1];
                    }
                });
                // This sets the filename for the downloaded file and serves the image
                res.download(destination, (err) => {
                    if (err) {
                        res.status(500).send('Error downloading the image.');
                    }
                });
            } catch (error) {
                res.status(500).json({error:`${error}`, stdout:`${error.stdout}`});
            }
        });
    }

    log(message) {
        console.log(`[${this.name}] ${message}`);
    }
}


module.exports = Get;
