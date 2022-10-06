// Copyright ©2022, GM Consult (Pty) Ltd.
// BSD 3-Clause License
// All rights reserved

/// Sample output from words endpoint.
const words = {
  'metadata': {
    'operation': 'retrieve',
    'provider': 'Oxford University Press',
    'schema': 'RetrieveEntry'
  },
  'query': 'swimming',
  'results': [
    {
      'id': 'swimming',
      'language': 'en-gb',
      'lexicalEntries': [
        {
          'entries': [
            {
              'grammaticalFeatures': [
                {'id': 'mass', 'text': 'Mass', 'type': 'Countability'}
              ],
              'inflections': [
                {'inflectedForm': 'swimming'}
              ],
              'pronunciations': [
                {
                  'audioFile':
                      'https://audio.oxforddictionaries.com/en/mp3/swimming__gb_2.mp3',
                  'dialects': ['British English'],
                  'phoneticNotation': 'IPA',
                  'phoneticSpelling': 'ˈswɪmɪŋ'
                }
              ],
              'senses': [
                {
                  'definitions': [
                    'the sport or activity of propelling oneself through water using the limbs'
                  ],
                  'domainClasses': [
                    {'id': 'swimming', 'text': 'Swimming'}
                  ],
                  'examples': [
                    {'text': 'Rachel had always loved swimming'},
                    {
                      'notes': [
                        {'text': 'as modifier', 'type': 'grammaticalNote'}
                      ],
                      'text': 'a swimming instructor'
                    }
                  ],
                  'id': 'm_en_gbus1021020.005',
                  'semanticClasses': [
                    {'id': 'water_sport', 'text': 'Water_Sport'}
                  ],
                  'shortDefinitions': [
                    'sport or activity of propelling oneself through water using limbs'
                  ]
                }
              ]
            }
          ],
          'language': 'en-gb',
          'lexicalCategory': {'id': 'noun', 'text': 'Noun'},
          'text': 'swimming'
        }
      ],
      'type': 'headword',
      'word': 'swimming'
    },
    {
      'id': 'swim',
      'language': 'en-gb',
      'lexicalEntries': [
        {
          'derivatives': [
            {'id': 'swimmable', 'text': 'swimmable'}
          ],
          'entries': [
            {
              'etymologies': [
                'Old English swimman (verb), of Germanic origin; related to Dutch zwemmen and German schwimmen'
              ],
              'grammaticalFeatures': [
                {
                  'id': 'intransitive',
                  'text': 'Intransitive',
                  'type': 'Subcategorization'
                }
              ],
              'inflections': [
                {
                  'grammaticalFeatures': [
                    {
                      'id': 'intransitive',
                      'text': 'Intransitive',
                      'type': 'Subcategorization'
                    }
                  ],
                  'inflectedForm': 'swims'
                },
                {
                  'grammaticalFeatures': [
                    {
                      'id': 'intransitive',
                      'text': 'Intransitive',
                      'type': 'Subcategorization'
                    }
                  ],
                  'inflectedForm': 'swimming'
                },
                {
                  'grammaticalFeatures': [
                    {
                      'id': 'intransitive',
                      'text': 'Intransitive',
                      'type': 'Subcategorization'
                    },
                    {'id': 'past', 'text': 'Past', 'type': 'Tense'}
                  ],
                  'inflectedForm': 'swam',
                  'pronunciations': [
                    {
                      'audioFile':
                          'https://audio.oxforddictionaries.com/en/mp3/swam__gb_1.mp3',
                      'dialects': ['British English'],
                      'phoneticNotation': 'IPA',
                      'phoneticSpelling': 'swam'
                    }
                  ]
                },
                {
                  'grammaticalFeatures': [
                    {
                      'id': 'intransitive',
                      'text': 'Intransitive',
                      'type': 'Subcategorization'
                    },
                    {
                      'id': 'pastParticiple',
                      'text': 'Past Participle',
                      'type': 'Non Finiteness'
                    }
                  ],
                  'inflectedForm': 'swum',
                  'pronunciations': [
                    {
                      'audioFile':
                          'https://audio.oxforddictionaries.com/en/mp3/swum__gb_1.mp3',
                      'dialects': ['British English'],
                      'phoneticNotation': 'IPA',
                      'phoneticSpelling': 'swʌm'
                    }
                  ]
                },
                {'inflectedForm': 'swam'},
                {'inflectedForm': 'swim'},
                {'inflectedForm': 'swimming'},
                {'inflectedForm': 'swims'},
                {'inflectedForm': 'swum'}
              ],
              'notes': [
                {
                  'text':
                      'In standard English the past tense of swim is swam (she swam to the shore) and the past participle is swum (she had never swum there before). In the 17th and 18th centuries swam and swum were used interchangeably for the past participle, but this is not acceptable in standard modern English',
                  'type': 'editorialNote'
                }
              ],
              'pronunciations': [
                {
                  'audioFile':
                      'https://audio.oxforddictionaries.com/en/mp3/swim__gb_1.mp3',
                  'dialects': ['British English'],
                  'phoneticNotation': 'IPA',
                  'phoneticSpelling': 'swɪm'
                }
              ],
              'senses': [
                {
                  'definitions': [
                    'propel the body through water by using the limbs, or (in the case of a fish or other aquatic animal) by using fins, tail, or other bodily movement'
                  ],
                  'domainClasses': [
                    {'id': 'swimming', 'text': 'Swimming'}
                  ],
                  'examples': [
                    {'text': 'they swam ashore'},
                    {'text': 'he swims thirty lengths twice a week'}
                  ],
                  'id': 'm_en_gbus1020960.013',
                  'shortDefinitions': [
                    'propel body through water by using limbs, or by using fins, tail'
                  ],
                  'subsenses': [
                    {
                      'definitions': [
                        'cross (a particular stretch of water) by swimming'
                      ],
                      'domainClasses': [
                        {'id': 'swimming', 'text': 'Swimming'}
                      ],
                      'examples': [
                        {'text': 'she swam the Channel'}
                      ],
                      'id': 'm_en_gbus1020960.019',
                      'notes': [
                        {'text': 'with object', 'type': 'grammaticalNote'}
                      ],
                      'shortDefinitions': ['cross stretch of water by swimming']
                    },
                    {
                      'definitions': ['float on or at the surface of a liquid'],
                      'examples': [
                        {'text': 'bubbles swam on the surface'}
                      ],
                      'id': 'm_en_gbus1020960.020',
                      'shortDefinitions': ['float on or at surface of liquid']
                    },
                    {
                      'definitions': ['cause to float or move across water'],
                      'examples': [
                        {
                          'text':
                              'they were able to swim their infantry carriers across'
                        }
                      ],
                      'id': 'm_en_gbus1020960.021',
                      'notes': [
                        {'text': 'with object', 'type': 'grammaticalNote'}
                      ],
                      'shortDefinitions': [
                        'cause to float or move across water'
                      ]
                    }
                  ],
                  'synonyms': [
                    {'language': 'en', 'text': 'bathe'},
                    {'language': 'en', 'text': 'go swimming'},
                    {'language': 'en', 'text': 'take a dip'},
                    {'language': 'en', 'text': 'dip'},
                    {'language': 'en', 'text': 'splash around'}
                  ],
                  'thesaurusLinks': [
                    {'entry_id': 'swim', 'sense_id': 't_en_gb0014530.001'}
                  ]
                },
                {
                  'definitions': ['be immersed in or covered with liquid'],
                  'examples': [
                    {'text': 'mashed potatoes swimming in gravy'}
                  ],
                  'id': 'm_en_gbus1020960.023',
                  'shortDefinitions': ['be immersed in or covered with liquid'],
                  'synonyms': [
                    {'language': 'en', 'text': 'be saturated in'},
                    {'language': 'en', 'text': 'be drenched in'},
                    {'language': 'en', 'text': 'be soaked in'},
                    {'language': 'en', 'text': 'be steeped in'},
                    {'language': 'en', 'text': 'be immersed in'},
                    {'language': 'en', 'text': 'be covered in'},
                    {'language': 'en', 'text': 'be full of'}
                  ],
                  'thesaurusLinks': [
                    {'entry_id': 'swim', 'sense_id': 't_en_gb0014530.002'}
                  ]
                },
                {
                  'definitions': ["appear to reel or whirl before one's eyes"],
                  'examples': [
                    {
                      'text':
                          'Emily rubbed her eyes as the figures swam before her eyes'
                    }
                  ],
                  'id': 'm_en_gbus1020960.025',
                  'shortDefinitions': [
                    "appear to reel or whirl before one's eyes"
                  ],
                  'subsenses': [
                    {
                      'definitions': [
                        "experience a dizzily confusing sensation in one's head"
                      ],
                      'examples': [
                        {'text': 'the drink made his head swim'}
                      ],
                      'id': 'm_en_gbus1020960.026',
                      'shortDefinitions': [
                        "experience dizzily confusing sensation in one's head"
                      ]
                    }
                  ],
                  'synonyms': [
                    {'language': 'en', 'text': 'go round'},
                    {'language': 'en', 'text': 'go round and round'},
                    {'language': 'en', 'text': 'whirl'},
                    {'language': 'en', 'text': 'spin'},
                    {'language': 'en', 'text': 'revolve'},
                    {'language': 'en', 'text': 'gyrate'},
                    {'language': 'en', 'text': 'swirl'},
                    {'language': 'en', 'text': 'twirl'},
                    {'language': 'en', 'text': 'turn'},
                    {'language': 'en', 'text': 'wheel'},
                    {'language': 'en', 'text': 'swim'}
                  ],
                  'thesaurusLinks': [
                    {'entry_id': 'reel', 'sense_id': 't_en_gb0012249.003'}
                  ]
                }
              ]
            }
          ],
          'language': 'en-gb',
          'lexicalCategory': {'id': 'verb', 'text': 'Verb'},
          'phrases': [
            {'id': 'in_the_swim', 'text': 'in the swim'},
            {'id': 'swim_against_the_tide', 'text': 'swim against the tide'},
            {'id': 'swim_with_the_tide', 'text': 'swim with the tide'}
          ],
          'text': 'swim'
        }
      ],
      'type': 'headword',
      'word': 'swim'
    }
  ]
};

/// Sample output from entries endpoint.
const entry = {
  'id': 'swim',
  'metadata': {
    'operation': 'retrieve',
    'provider': 'Oxford University Press',
    'schema': 'RetrieveEntry'
  },
  'results': [
    {
      'id': 'swim',
      'language': 'en-gb',
      'lexicalEntries': [
        {
          'derivatives': [
            {'id': 'swimmable', 'text': 'swimmable'}
          ],
          'entries': [
            {
              'etymologies': [
                'Old English swimman (verb), of Germanic origin; related to Dutch zwemmen and German schwimmen'
              ],
              'grammaticalFeatures': [
                {
                  'id': 'intransitive',
                  'text': 'Intransitive',
                  'type': 'Subcategorization'
                }
              ],
              'inflections': [
                {
                  'grammaticalFeatures': [
                    {
                      'id': 'intransitive',
                      'text': 'Intransitive',
                      'type': 'Subcategorization'
                    }
                  ],
                  'inflectedForm': 'swims'
                },
                {
                  'grammaticalFeatures': [
                    {
                      'id': 'intransitive',
                      'text': 'Intransitive',
                      'type': 'Subcategorization'
                    }
                  ],
                  'inflectedForm': 'swimming'
                },
                {
                  'grammaticalFeatures': [
                    {
                      'id': 'intransitive',
                      'text': 'Intransitive',
                      'type': 'Subcategorization'
                    },
                    {'id': 'past', 'text': 'Past', 'type': 'Tense'}
                  ],
                  'inflectedForm': 'swam',
                  'pronunciations': [
                    {
                      'audioFile':
                          'https://audio.oxforddictionaries.com/en/mp3/swam__gb_1.mp3',
                      'dialects': ['British English'],
                      'phoneticNotation': 'IPA',
                      'phoneticSpelling': 'swam'
                    }
                  ]
                },
                {
                  'grammaticalFeatures': [
                    {
                      'id': 'intransitive',
                      'text': 'Intransitive',
                      'type': 'Subcategorization'
                    },
                    {
                      'id': 'pastParticiple',
                      'text': 'Past Participle',
                      'type': 'Non Finiteness'
                    }
                  ],
                  'inflectedForm': 'swum',
                  'pronunciations': [
                    {
                      'audioFile':
                          'https://audio.oxforddictionaries.com/en/mp3/swum__gb_1.mp3',
                      'dialects': ['British English'],
                      'phoneticNotation': 'IPA',
                      'phoneticSpelling': 'swʌm'
                    }
                  ]
                }
              ],
              'notes': [
                {
                  'text':
                      'In standard English the past tense of swim is swam (she swam to the shore) and the past participle is swum (she had never swum there before). In the 17th and 18th centuries swam and swum were used interchangeably for the past participle, but this is not acceptable in standard modern English',
                  'type': 'editorialNote'
                }
              ],
              'pronunciations': [
                {
                  'audioFile':
                      'https://audio.oxforddictionaries.com/en/mp3/swim__gb_1.mp3',
                  'dialects': ['British English'],
                  'phoneticNotation': 'IPA',
                  'phoneticSpelling': 'swɪm'
                }
              ],
              'senses': [
                {
                  'definitions': [
                    'propel the body through water by using the limbs, or (in the case of a fish or other aquatic animal) by using fins, tail, or other bodily movement'
                  ],
                  'domainClasses': [
                    {'id': 'swimming', 'text': 'Swimming'}
                  ],
                  'examples': [
                    {'text': 'they swam ashore'},
                    {'text': 'he swims thirty lengths twice a week'}
                  ],
                  'id': 'm_en_gbus1020960.013',
                  'shortDefinitions': [
                    'propel body through water by using limbs, or by using fins, tail'
                  ],
                  'subsenses': [
                    {
                      'definitions': [
                        'cross (a particular stretch of water) by swimming'
                      ],
                      'domainClasses': [
                        {'id': 'swimming', 'text': 'Swimming'}
                      ],
                      'examples': [
                        {'text': 'she swam the Channel'}
                      ],
                      'id': 'm_en_gbus1020960.019',
                      'notes': [
                        {'text': 'with object', 'type': 'grammaticalNote'}
                      ],
                      'shortDefinitions': ['cross stretch of water by swimming']
                    },
                    {
                      'definitions': ['float on or at the surface of a liquid'],
                      'examples': [
                        {'text': 'bubbles swam on the surface'}
                      ],
                      'id': 'm_en_gbus1020960.020',
                      'shortDefinitions': ['float on or at surface of liquid']
                    },
                    {
                      'definitions': ['cause to float or move across water'],
                      'examples': [
                        {
                          'text':
                              'they were able to swim their infantry carriers across'
                        }
                      ],
                      'id': 'm_en_gbus1020960.021',
                      'notes': [
                        {'text': 'with object', 'type': 'grammaticalNote'}
                      ],
                      'shortDefinitions': [
                        'cause to float or move across water'
                      ]
                    }
                  ],
                  'synonyms': [
                    {'language': 'en', 'text': 'bathe'},
                    {'language': 'en', 'text': 'go swimming'},
                    {'language': 'en', 'text': 'take a dip'},
                    {'language': 'en', 'text': 'dip'},
                    {'language': 'en', 'text': 'splash around'}
                  ],
                  'thesaurusLinks': [
                    {'entry_id': 'swim', 'sense_id': 't_en_gb0014530.001'}
                  ]
                },
                {
                  'definitions': ['be immersed in or covered with liquid'],
                  'examples': [
                    {'text': 'mashed potatoes swimming in gravy'}
                  ],
                  'id': 'm_en_gbus1020960.023',
                  'shortDefinitions': ['be immersed in or covered with liquid'],
                  'synonyms': [
                    {'language': 'en', 'text': 'be saturated in'},
                    {'language': 'en', 'text': 'be drenched in'},
                    {'language': 'en', 'text': 'be soaked in'},
                    {'language': 'en', 'text': 'be steeped in'},
                    {'language': 'en', 'text': 'be immersed in'},
                    {'language': 'en', 'text': 'be covered in'},
                    {'language': 'en', 'text': 'be full of'}
                  ],
                  'thesaurusLinks': [
                    {'entry_id': 'swim', 'sense_id': 't_en_gb0014530.002'}
                  ]
                },
                {
                  'definitions': ["appear to reel or whirl before one's eyes"],
                  'examples': [
                    {
                      'text':
                          'Emily rubbed her eyes as the figures swam before her eyes'
                    }
                  ],
                  'id': 'm_en_gbus1020960.025',
                  'shortDefinitions': [
                    "appear to reel or whirl before one's eyes"
                  ],
                  'subsenses': [
                    {
                      'definitions': [
                        "experience a dizzily confusing sensation in one's head"
                      ],
                      'examples': [
                        {'text': 'the drink made his head swim'}
                      ],
                      'id': 'm_en_gbus1020960.026',
                      'shortDefinitions': [
                        "experience dizzily confusing sensation in one's head"
                      ]
                    }
                  ],
                  'synonyms': [
                    {'language': 'en', 'text': 'go round'},
                    {'language': 'en', 'text': 'go round and round'},
                    {'language': 'en', 'text': 'whirl'},
                    {'language': 'en', 'text': 'spin'},
                    {'language': 'en', 'text': 'revolve'},
                    {'language': 'en', 'text': 'gyrate'},
                    {'language': 'en', 'text': 'swirl'},
                    {'language': 'en', 'text': 'twirl'},
                    {'language': 'en', 'text': 'turn'},
                    {'language': 'en', 'text': 'wheel'},
                    {'language': 'en', 'text': 'swim'}
                  ],
                  'thesaurusLinks': [
                    {'entry_id': 'reel', 'sense_id': 't_en_gb0012249.003'}
                  ]
                }
              ]
            }
          ],
          'language': 'en-gb',
          'lexicalCategory': {'id': 'verb', 'text': 'Verb'},
          'phrases': [
            {'id': 'in_the_swim', 'text': 'in the swim'},
            {'id': 'swim_against_the_tide', 'text': 'swim against the tide'},
            {'id': 'swim_with_the_tide', 'text': 'swim with the tide'}
          ],
          'text': 'swim'
        },
        {
          'derivatives': [
            {'id': 'swimmable', 'text': 'swimmable'}
          ],
          'entries': [
            {
              'notes': [
                {
                  'text':
                      'In standard English the past tense of swim is swam (she swam to the shore) and the past participle is swum (she had never swum there before). In the 17th and 18th centuries swam and swum were used interchangeably for the past participle, but this is not acceptable in standard modern English',
                  'type': 'editorialNote'
                }
              ],
              'pronunciations': [
                {
                  'audioFile':
                      'https://audio.oxforddictionaries.com/en/mp3/swim__gb_1.mp3',
                  'dialects': ['British English'],
                  'phoneticNotation': 'IPA',
                  'phoneticSpelling': 'swɪm'
                }
              ],
              'senses': [
                {
                  'definitions': ['an act or period of swimming'],
                  'domainClasses': [
                    {'id': 'swimming', 'text': 'Swimming'}
                  ],
                  'examples': [
                    {'text': 'we went for a swim in the river'}
                  ],
                  'id': 'm_en_gbus1020960.029',
                  'semanticClasses': [
                    {'id': 'swim', 'text': 'Swim'}
                  ],
                  'shortDefinitions': ['act or period of swimming'],
                  'synonyms': [
                    {'language': 'en', 'text': 'swim'},
                    {'language': 'en', 'text': 'bathe'},
                    {'language': 'en', 'text': 'dive'},
                    {'language': 'en', 'text': 'plunge'},
                    {'language': 'en', 'text': 'splash'},
                    {'language': 'en', 'text': 'paddle'}
                  ],
                  'thesaurusLinks': [
                    {'entry_id': 'dip', 'sense_id': 't_en_gb0003980.010'}
                  ]
                },
                {
                  'definitions': [
                    'a pool in a river that is a particularly good spot for fishing'
                  ],
                  'domainClasses': [
                    {'id': 'angling', 'text': 'Angling'}
                  ],
                  'examples': [
                    {'text': 'he landed two 5 lb chub from the same swim'}
                  ],
                  'id': 'm_en_gbus1020960.033',
                  'semanticClasses': [
                    {'id': 'body_of_water', 'text': 'Body_Of_Water'}
                  ],
                  'shortDefinitions': ['pool that is good spot for fishing']
                }
              ]
            }
          ],
          'language': 'en-gb',
          'lexicalCategory': {'id': 'noun', 'text': 'Noun'},
          'phrases': [
            {'id': 'in_the_swim', 'text': 'in the swim'},
            {'id': 'swim_against_the_tide', 'text': 'swim against the tide'},
            {'id': 'swim_with_the_tide', 'text': 'swim with the tide'}
          ],
          'text': 'swim'
        }
      ],
      'type': 'headword',
      'word': 'swim'
    }
  ],
  'word': 'swim'
};
