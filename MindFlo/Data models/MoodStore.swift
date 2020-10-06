//
//  MoodStore.swift
//  MindFlo
//
//  Created by Adit Gupta on 09/08/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import Combine

class MoodStore {
    // For vertical grid
    var allMoods = [
        //Yellow
        Mood(moodType: 1, moodEmoji: "😀", moodTitles: ["Happy", "Joyful"] ),
        Mood(moodType: 1, moodEmoji: "😘", moodTitles: ["Playful", "Cheeky", "Aroused"] ),
        Mood(moodType: 1, moodEmoji: "😌", moodTitles: ["Content", "Peaceful", "Relaxed"] ),
        Mood(moodType: 1, moodEmoji: "👏", moodTitles: ["Grateful", "Thankful"] ),
        Mood(moodType: 1, moodEmoji: "😇", moodTitles: ["Accepted", "Respected", "Valued"] ),
        Mood(moodType: 1, moodEmoji: "🤩", moodTitles: ["Hopeful", "Optimistic", "Inspired"] ),
        Mood(moodType: 1, moodEmoji: "🥰", moodTitles: ["Trusting", "Intimate", "Loving"] ),
        Mood(moodType: 1, moodEmoji: "🥳", moodTitles: ["Excited", "Eager", "Energetic"] ),
        Mood(moodType: 1, moodEmoji: "💪", moodTitles: ["Empowered", "Courageous", "Productive"] ),
        Mood(moodType: 1, moodEmoji: "🙌", moodTitles: ["Proud", "Successful", "Confident"] ),
        Mood(moodType: 1, moodEmoji: "😲", moodTitles: ["Amazed", "Astonished", "Awe"] ),
        
        //Blue
        Mood(moodType: 2, moodEmoji: "😞", moodTitles: ["Sad", "Gloomy", "Dejected" ] ),
        Mood(moodType: 2, moodEmoji: "😣", moodTitles: ["Lonely", "Isolated", "Abandoned"] ),
        Mood(moodType: 2, moodEmoji: "🥺", moodTitles: ["Vulnerable", "Fragile", "Victimised"] ),
        Mood(moodType: 2, moodEmoji: "😭", moodTitles: ["Grief", "Despair"] ),
        Mood(moodType: 2, moodEmoji: "🤥", moodTitles: ["Guilty", "Ashamed", "Remorseful"] ),
        Mood(moodType: 2, moodEmoji: "😖", moodTitles: ["Depressed", "Inferior"] ),
        Mood(moodType: 2, moodEmoji: "🤕", moodTitles: ["Hurt", "Embarrassed", "Disappointed"] ),
        Mood(moodType: 2, moodEmoji: "😶", moodTitles: ["Numb", "Withdrawn", "Empty"] ),
        Mood(moodType: 2, moodEmoji: "👀", moodTitles: ["Distant","Aloof", "Detached"] ),
        
        //Red
        Mood(moodType: 3, moodEmoji: "😠", moodTitles: ["Angry", "Mad", "Furious"] ),
        Mood(moodType: 3, moodEmoji: "🤬", moodTitles: ["Aggressive", "Provoked", "Hostile"] ),
        Mood(moodType: 3, moodEmoji: "😡", moodTitles: ["Frustrated", "Infuriated", "Annoyed"] ),
        Mood(moodType: 3, moodEmoji: "🤨", moodTitles: ["Critical", "Sceptical", "Dismissive"] ),
        Mood(moodType: 3, moodEmoji: "👿", moodTitles: ["Betrayed", "Resentful"] ),
        Mood(moodType: 3, moodEmoji: "😤", moodTitles: ["Humiliated", "Disrespected", "Ridiculed"] ),
        Mood(moodType: 3, moodEmoji: "🤯", moodTitles: ["Stressed", "Overwhelmed", "Out of control"] ),
        Mood(moodType: 3, moodEmoji: "😪", moodTitles: ["Tired", "Unfocussed", "Distracted"] ),
        
        //Purple
        Mood(moodType: 4, moodEmoji: "😨", moodTitles: ["Fearful", "Scared"] ),
        Mood(moodType: 4, moodEmoji: "😰", moodTitles: ["Anxious", "Overwhelmed", "Worried"] ),
        Mood(moodType: 4, moodEmoji: "😧", moodTitles: ["Insecure", "Inadequate", "Inferior"] ),
        Mood(moodType: 4, moodEmoji: "😩", moodTitles: ["Weak", "Worthless", "Insignificant"] ),
        Mood(moodType: 4, moodEmoji: "✋", moodTitles: ["Rejected", "Persecuted", "Excluded"] ),
        Mood(moodType: 4, moodEmoji: "😬", moodTitles: ["Nervous",  "Threatened", "Exposed"] ),
        Mood(moodType: 4, moodEmoji: "😵", moodTitles: ["Pressured", "Rushed", "Horrified"] ),
        Mood(moodType: 4, moodEmoji: "😟", moodTitles: ["Threatened", "Helpless"] ),
        
        //Green
        Mood(moodType: 5, moodEmoji: "🤢", moodTitles: ["Disgusted", "Apalled"] ),
        Mood(moodType: 5, moodEmoji: "🙄", moodTitles: ["Disappointed", "Revolted"] ),
        Mood(moodType: 5, moodEmoji: "🤮", moodTitles: ["Awful", "Nauseated", "Sick"] ),
        Mood(moodType: 5, moodEmoji: "🤭", moodTitles: ["Repelled", "Hesitant"] ),
        Mood(moodType: 5, moodEmoji: "🧐", moodTitles: ["Judgemental", "Disapproving"] ),
        Mood(moodType: 5, moodEmoji: "😑", moodTitles: ["Apathetic", "Indifferent"] ),
        Mood(moodType: 5, moodEmoji: "🥱", moodTitles: ["Bored", "Sleepy"] ),
        Mood(moodType: 5, moodEmoji: "🥴", moodTitles: ["Weird", "Unusual", "Cranky"] )
    ]
    
    
    
    
    
    
    

    
    //For horizontal scroll
    @Published var happy = [
        Mood(moodType: 1, moodEmoji: "😀", moodTitles: ["Happy", "Joyful"] ),
        Mood(moodType: 1, moodEmoji: "😘", moodTitles: ["Playful", "Cheeky", "Aroused"] ),
        Mood(moodType: 1, moodEmoji: "😌", moodTitles: ["Content", "Peaceful", "Relaxed"] ),
        Mood(moodType: 1, moodEmoji: "👏", moodTitles: ["Grateful", "Thankful"] ),
        Mood(moodType: 1, moodEmoji: "😇", moodTitles: ["Accepted", "Respected", "Valued"] ),
        Mood(moodType: 1, moodEmoji: "🤩", moodTitles: ["Hopeful", "Optimistic", "Inspired"] ),
        Mood(moodType: 1, moodEmoji: "🥰", moodTitles: ["Trusting", "Intimate", "Loving"] ),
        Mood(moodType: 1, moodEmoji: "🥳", moodTitles: ["Excited", "Eager", "Energetic"] ),
        Mood(moodType: 1, moodEmoji: "💪", moodTitles: ["Empowered", "Courageous", "Productive"] ),
        Mood(moodType: 1, moodEmoji: "🙌", moodTitles: ["Proud", "Successful", "Confident"] ),
        Mood(moodType: 1, moodEmoji: "😲", moodTitles: ["Amazed", "Astonished", "Awe"] )
    ]
    
    @Published var sad = [
        Mood(moodType: 2, moodEmoji: "😞", moodTitles: ["Sad", "Gloomy", "Dejected" ] ),
        Mood(moodType: 2, moodEmoji: "😣", moodTitles: ["Lonely", "Isolated", "Abandoned"] ),
        Mood(moodType: 2, moodEmoji: "🥺", moodTitles: ["Vulnerable", "Fragile", "Victimised"] ),
        Mood(moodType: 2, moodEmoji: "😭", moodTitles: ["Grief", "Despair"] ),
        Mood(moodType: 2, moodEmoji: "🤥", moodTitles: ["Guilty", "Ashamed", "Remorseful"] ),
        Mood(moodType: 2, moodEmoji: "😖", moodTitles: ["Depressed", "Inferior"] ),
        Mood(moodType: 2, moodEmoji: "🤕", moodTitles: ["Hurt", "Embarrassed", "Disappointed"] ),
        Mood(moodType: 2, moodEmoji: "😶", moodTitles: ["Numb", "Withdrawn", "Empty"] ),
    ]
    
    @Published var angry = [
        Mood(moodType: 3, moodEmoji: "😠", moodTitles: ["Angry", "Mad", "Furious"] ),
        Mood(moodType: 3, moodEmoji: "🤬", moodTitles: ["Aggressive", "Provoked", "Hostile"] ),
        Mood(moodType: 3, moodEmoji: "😡", moodTitles: ["Frustrated", "Infuriated", "Annoyed"] ),
        Mood(moodType: 3, moodEmoji: "🤨", moodTitles: ["Critical", "Sceptical", "Dismissive"] ),
        Mood(moodType: 3, moodEmoji: "👿", moodTitles: ["Betrayed", "Resentful"] ),
        Mood(moodType: 3, moodEmoji: "😤", moodTitles: ["Humiliated", "Disrespected", "Ridiculed"] ),
        Mood(moodType: 3, moodEmoji: "🤯", moodTitles: ["Stressed", "Overwhelmed", "Out of control"] ),
        Mood(moodType: 3, moodEmoji: "😪", moodTitles: ["Tired", "Unfocussed", "Distracted"] )
    ]
    
    @Published var fearful = [
        Mood(moodType: 4, moodEmoji: "😨", moodTitles: ["Fearful", "Scared"] ),
        Mood(moodType: 4, moodEmoji: "😰", moodTitles: ["Anxious", "Overwhelmed", "Worried"] ),
        Mood(moodType: 4, moodEmoji: "😧", moodTitles: ["Insecure", "Inadequate", "Inferior"] ),
        Mood(moodType: 4, moodEmoji: "😩", moodTitles: ["Weak", "Worthless", "Insignificant"] ),
        Mood(moodType: 4, moodEmoji: "✋", moodTitles: ["Rejected", "Persecuted", "Excluded"] ),
        Mood(moodType: 4, moodEmoji: "😬", moodTitles: ["Nervous",  "Threatened", "Exposed"] ),
        Mood(moodType: 4, moodEmoji: "😵", moodTitles: ["Pressured", "Rushed"] ),
        Mood(moodType: 4, moodEmoji: "😟", moodTitles: ["Threatened", "Helpless"] )
    ]
    
    @Published var disgust = [
        Mood(moodType: 5, moodEmoji: "🤢", moodTitles: ["Disgusted", "Apalled"] ),
        Mood(moodType: 5, moodEmoji: "🙄", moodTitles: ["Disappointed", "Revolted"] ),
        Mood(moodType: 5, moodEmoji: "🤮", moodTitles: ["Awful", "Nauseated", "Sick"] ),
        Mood(moodType: 5, moodEmoji: "🤭", moodTitles: ["Repelled", "Hesitant", "Horrified"] ),
        Mood(moodType: 5, moodEmoji: "🧐", moodTitles: ["Judgemental", "Disapproving"] ),
        Mood(moodType: 5, moodEmoji: "😑", moodTitles: ["Apathetic", "Indifferent"] ),
        Mood(moodType: 5, moodEmoji: "🥱", moodTitles: ["Bored", "Sleepy"] )
    ]
}
