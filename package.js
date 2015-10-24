Package.describe({
    summary: 'Client & Server events',
    version: '0.0.2',
    name: 'mcbrumagin:meteor-events',
    git: 'https://github.com/mcbrumagin/meteor-events.git'
})

Package.onUse(function(api) {
    api.use(['mongo@1.0.10'], ['client', 'server'])
    api.use(['coffeescript@1.0.10'], ['client', 'server'])
    api.addFiles('events.coffee')
    api.export('Events', ['client', 'server'])
})
