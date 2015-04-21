acb.hash = ((win, $) ->

  funcs =
    onHashChance : (h)->
      return

  $(win).on 'hashchange', (e)->
    hash = getHash();
    funcs['onHashChance'](hash)

  getHash = ->
    return window.location.hash.replace '#', ''

  setHash = (hash)->
    window.location.hash = hash

  register = (f)->
    if funcs['onHashChance']
      funcs['onHashChance'] = f

  return {
    getHash : getHash
    setHash : setHash
    register : register
  }) window, jQuery

