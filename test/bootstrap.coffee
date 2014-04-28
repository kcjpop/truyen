# Define the environment
process.env.NODE_ENV = 'test'

# ChaiJS
require('chai').should()

# Supertest for testing APIs
global.request = require 'supertest'

# Database seeding
require '../app/seeds'
