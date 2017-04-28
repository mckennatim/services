var nodemailer = require('nodemailer')
let transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: 'mckenna.tim@gmail.com',
        pass: 'gmlo9ijn'
    }
});
var mailOpts = {
    from: "Stuff2Get <mckenna.tim@gmail.com>", // sender address
    to: "mckenna.tim@gmail.com", // list of receivers
    subject: "apikey", // Subject line
    text: "Your apikey for stuff2get is: Return to the web page and enter your apikey to complete registration for your device", // plaintext body
    html: "<b>Your apikey for stuff2get is: </b><p>Return to the web page and enter your apikey to complete registration for your device </b></p>" // html body
}
transporter.sendMail(mailOpts, (error, info) => {
    if (error) {
        return console.log(error);
    }
    console.log('Message %s sent: %s', info.messageId, info.response);
});