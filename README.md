# Patient Feedback Collection System (PFCS)
This repository contains a Patient Feedback Collection System (PFCS) built with Ruby on Rails, React, and Tailwind CSS. The system allows healthcare providers to collect feedback from patients through a web interface.

## Versions
- Ruby: 3.2.2
- Rails: 8.0.2

## Requirements
- Ruby 3.2.2 or higher
- Rails 8.0.2 or higher
- Node.js and Yarn for managing JavaScript dependencies
- SQLite3 for the database

## Installation
1. Clone the repository:
   ```bash
   git clone
   bundle install
   rake db:setup
   yarn install
   ```

## Running the Application
To start the Rails server, run the following command:

```bash
bin/dev
```

then open your web browser and navigate to `http://localhost:3000`.

## Testing
This project is set up to use RSpec for testing. To run the test suite, use the following command:

```bash
bundle exec rspec
```

## Linting
This project uses RuboCop for linting. To check the code style, run:

```bash
bundle exec rubocop
```

## Design decisions