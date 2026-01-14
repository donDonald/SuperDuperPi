const util = require('util');
const exec_cb = require('child_process').exec;
const exec = util.promisify(exec_cb);


class Toggle
{
    constructor()
    {
        this.name = "leds.Toggle";
        this.target_directory = `${process.env.SUPER_DUPER_PI_SURVELIANCE_ROOT}/scripts/leds`;
    }

    log(message)
    {
        console.log(`[${this.name}] ${message}`);
    }

    async do(index)
    {
        this.log(`do(${index}) {`)
        let result;
        try
        {
            const cmd = `./toggle.sh ${index}`;
            let {stdout, stderr} = await exec(cmd, {cwd: this.target_directory});
            result = [stdout, stderr];
        }
        catch (error)
        {
            throw error;
        }
        this.log(`} do(${index})`)
        return result[0];
    }
}


class Post
{
    constructor(app)
    {
        this.name = "leds.Toggle.Post";
        this.toggle = new Toggle();
        app.post('/leds/api/toggle', async (req, res) => {
            try
            {
                const index = req.body.index;
                const result = await this.toggle.do(index);
                res.status(200).send(result);
            }
            catch (error)
            {
                res.status(500).render('error', {
                    title: 'Error',
                    explanation0: `${error}`,
                    explanation1: `${error.stdout}`
                });
            }
        });
    }

    log(message)
    {
        console.log(`[${this.name}] ${message}`);
    }
}


module.exports = Post;
