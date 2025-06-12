# Patient Feedback Collection System (PFCS)
This repository contains a Patient Feedback Collection System (PFCS) built with Ruby on Rails. The system allows healthcare providers to collect feedback from patients through a web interface.

## Versions
- Ruby: 3.2.2
- Rails: 8.0.2

## Requirements
- Ruby 3.2.2 or higher
- Rails 8.0.2 or higher
- Node.js and Yarn for managing JavaScript dependencies
- SQLite3 for the database
- OpenAI API key for AI integration

## Installation
1. Clone the repository:
   ```bash
   git clone
   bundle install
   rake db:setup
   yarn install
   ```
   
### Setting up the OpenAI API key
Normally, I would use either a secure key/value store or environment variables to store the OpenAI API key.
In this case, for ease of setup, I have added the OpenAI API key directly in the caller of the AI service.

To use the AI features, add your OpenAI API key to the `Ai::OpenAi::Responses` service object in `app/services/ai/open_ai/responses.rb`:

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
### Realistic, Scalable Design
For scalability, I picked two things to concentrate on. First is running long-running tasks like data importing and AI
requests in the background. The second is avoiding strict relationships and foreign keys in the database. This lets me pull
in the data in any order instead of needing to wait for the data to be imported in a specific order. This is especially
useful when importing data from external sources where the order of data may not be guaranteed.

The way the modeling is designed lets me do quick SQL Joins on the data as well as providing an easy-to-use interface for
the developer. If there was more data, I would add pagination to the Doctor and Patient appointments views to speed up those up. 

### AI Integration
For the AI integration, I used the OpenAI API to analyze patient feedback. The AI model is set up to process feedback and
provide insights into patient sentiment, find additional resources, and suggest organizations and groups that can help. 
This is designed to run in a background job after the feedback is submitted and then emails a response to the patient.

While building the app, I used multiple different AI tools to help speed up the development process. I used GitHub Copilot
to help write code and generate outlines in tests. I used Anthropic's Claude to help figure get the class names for the
basic UI design. Finally, I used OpenAI's GPT-4 for the AI work described above as well as quick "Fix it" calls inside 
my editor.

## Parts
### DataProvider::Load, ParseRecordsJob, and EntryParsers
These classes are responsible for loading data from external sources and parsing it into the application's format. They
handle the import of patient feedback and other related data and are broken down into smaller, manageable service objects
to keep the code clean and maintainable. To add a new resource type, add the database modeling, create a new entry
parser, and add it to the ParseRecords job.

### Ai::OpenAi::Responses
I created a service object to handle the AI responses from OpenAI. This class is responsible for making requests to the
OpenAI API and processing the responses. It abstracts the complexity of interacting with the AI API and provides a simple
interface for the rest of the application to use. It's structured as Ai/OpenAi/Responses is designed to allow expansion
for other AI providers and other endpoints from OpenAI in the future.

### The backend
The backend is built with Ruby on Rails and follows the MVC architecture. It provides a RESTful API for the frontend to
interact with. The backend handles data storage, retrieval, and processing of patient feedback. Shared views are broken
down into partials to make building new UI components easier.

#### API Endpoints
GET /doctors

GET /doctors/:id

GET /patients

GET /patients/:id

POST /appointments/:appointment_id/feedback_responses

GET /appointments/:appointment_id/feedback_responses/new

GET /appointments/:appointment_id/feedback_responses/:id

### The frontend
The frontend is built with Rails views for simplicity and speed. It uses Tailwind CSS for simplistic styling. I decided
against a single-page application (SPA) framework like React or Vue.js both to keep the project lightweight and because
the interactions are currently minimal. I made the assumption that part of the flow happens in the doctor's office, and
the feedback happens at a later time, so the user doesn't need to be in the app for long periods of time.

### Future Improvements
- **AI Model Improvements**: The AI model can be improved to provide more accurate sentiment analysis and insights.
- **Pagination**: Implement pagination for the Doctor and Patient appointments views to improve performance with larger datasets.
- **Enhanced UI/UX**: Improve the user interface and user experience with more interactive elements and better feedback mechanisms.
- **Entity parsing**: Further enhance the entity parsing to handle more complex data structures and relationships.
- **Editing feedback**: Allow users to edit their feedback after submission.
- **Authentication**: Implement user authentication to secure the application and restrict access to sensitive data.

## AI email sample
```
Feedback followup:

We've received your feedback for your appointment on April 02, 2021.

Thank you for sharing your feedback. We acknowledge your comments about the communication around your diagnosis management. If you have any further questions or need clarification about your care plan, please let us know.

You have been diagnosed with diabetes without complications. Here are some important points to help you manage your health:

**1. Blood Sugar Monitoring:**
Regularly check your blood sugar levels as directed by your healthcare provider. This helps you and your doctor understand how well your treatment plan is working.

**2. Medication:**
You may be prescribed oral medications and/or insulin depending on your individual needs. Take your medications exactly as directed.

**3. Healthy Eating:**
Focus on a balanced diet that includes whole grains, lean protein, vegetables, and fruits. Limit foods and drinks high in sugar and refined carbohydrates.

**4. Physical Activity:**
Aim for at least 150 minutes of moderate exercise each week, such as brisk walking, cycling, or swimming. Always check with your doctor before starting new physical activities.

**5. Regular Check-ups:**
Keep all medical appointments for monitoring your progress and screening for possible complications.

**6. Foot Care:**
Check your feet daily for sores, blisters, redness, or swelling. Diabetes can affect circulation and sensation.

**7. Stress Management:**
Try to manage stress through relaxation techniques, hobbies, or talking with a counselor if needed, as stress can affect blood sugar levels.

**8. Know Signs of High/Low Blood Sugar:**
Learn to recognize symptoms of high blood sugar (increased thirst, frequent urination) and low blood sugar (shakiness, sweating, confusion). Know when to seek help.

If you have questions about your diagnosis, medications, or need support making lifestyle changes, please reach out to your healthcare team. Regular management can help prevent complications and improve your quality of life.

Here are some organizations and groups that can provide support and resources for individuals managing diabetes without complications:

- **American Diabetes Association (ADA)**
  Website: diabetes.org
  Offers education, advocacy, and community programs for people living with diabetes.

- **Juvenile Diabetes Research Foundation (JDRF)**
  Website: jdrf.org
  While focused on type 1 diabetes, they provide community support and advocacy that may be useful.

- **DiabetesSisters**
  Website: diabetessisters.org
  Provides peer support and education, specifically for women living with any type of diabetes.

- **Local Hospital or Clinic-Based Diabetes Education Programs**
  Many hospitals and clinics offer diabetes education classes or support groups where you can learn more about managing diabetes and connect with others.

- **National Institute of Diabetes and Digestive and Kidney Diseases (NIDDK)**
  Website: niddk.nih.gov
  Offers reliable information and resources for patients and families dealing with diabetes.

Connecting with one or more of these organizations can offer you information, community, and practical tips as you adjust to your diagnosis.

Please let us know if you have any further questions or concerns. You can reply to this email or contact us through our website.

Thanks,

Your care team
```