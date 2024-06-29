const dotenv = require('dotenv').config();
const { GoogleGenerativeAI } = require("@google/generative-ai");

const apiKey = process.env.API_KEY
const genAI = new GoogleGenerativeAI(apiKey);
const model = genAI.getGenerativeModel({ 
    model: "gemini-1.5-flash",
    systemInstruction: "You are a mental health assistance and your job is to accompany the user and give them a helpful advise on their mental health issues",
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
