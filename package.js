Package.describe({
    summary: 'Client & Server events',
    version: '0.0.1',
    name: 'sirpy:meteor-events',
    git: 'https://github.com/sirpy/meteor-events.git'
})

Package.onUse(function(api) {
    api.use(['mongo@1.0.10'], ['client', 'server'])
    api.use(['coffeescript@1.0.10'], ['client', 'server'])
    api.addFiles('events.coffee')
    api.export('Events', ['client', 'server'])
})
