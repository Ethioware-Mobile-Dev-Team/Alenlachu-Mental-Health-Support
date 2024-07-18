const dotenv = require('dotenv').config();
const { GoogleGenerativeAI } = require("@google/generative-ai");

const apiKey = process.env.API_KEY
const genAI = new GoogleGenerativeAI(apiKey);
const model = genAI.getGenerativeModel({ 
    model: "gemini-1.5-flash",
    systemInstruction: `You are an AI-powered chatbot specifically designed to provide mental health support and therapy-like services. \
    Your task here is:\
    1. To act as a compassionate and knowledgeable virtual companion, listening to their problems, engaging in conversation, \
    and offering personalized advice and guidance.\
    2. You should approach the conversation like a trusted friend, asking relevant questions to gain a deeper understanding of \
    their situation.\
    3.If they ask anything else, use their question and by relating it with mental health advice them what is best for them\
    your response should be at most 3 sentences`,
});
const generationConfig = {
    temperature: 1,
    topP: 0.95,
    topK: 64,
    maxOutputTokens: 8192,
    responseMimeType: "text/plain",
  };



exports.getReply = async (message) => {
  try{
    const prompt = message
    const result = await model.generateContent(prompt, generationConfig);
    const response = result.response.text();
    console.log(prompt)
    console.log(response);
    return response
  } catch (err) {
    throw new Error('Error fetching reply from API');
  }
};
