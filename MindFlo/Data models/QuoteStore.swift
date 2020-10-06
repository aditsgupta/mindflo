//
//  QuoteStore.swift
//  MindFlo
//
//  Created by Adit Gupta on 12/09/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import Foundation

class QuoteStore {
    let allQuotes = [
        
        Quote(title: "Knowing yourself is to be rooted in Being, instead of lost in your mind.", author: "Eckhart Tolle"),
        Quote(title: "Not thinking about anything is Zen. Once you know this, walking, sitting, or lying down, everything you do is Zen.", author: "Bodhidharma"),
        Quote(title: "The secret of health for both mind and body is not to mourn for the past, nor to worry about the future, but to live the present moment wisely and earnestly.", author: "Siddhārtha Gautama"),
        Quote(title: "The only limit to your impact is your imagination and commitment. ", author: "Anthony Robins"),
        Quote(title: "Mental toughness is Spartanism with qualities of sacrifice, self-denial, dedication. It is fearlessness, and it is love. ", author: "Vince Lombardi"),
        Quote(title: "It’s when the discomfort strikes that they realize a strong mind is the most powerful weapon of all. ", author: "Chrissie Wellington"),
        Quote(title: "Throw away all weakness. Tell your body that it is strong, tell your mind that it is strong and have unbounded faith and hope in yourself.", author: "Swami Vivekananda"),
        Quote(title: "To understand the immeasurable, the mind must be extraordinarily quiet, still", author: "Jiddu Krishnamurti"),
        Quote(title: "As you breathe in, cherish yourself. As you breathe out, cherish all beings.", author: "Dalai Lama"),
        Quote(title: "A disciplined mind leads to happiness, and an undisciplined mind leads to suffering.", author: "Dalai Lama"),
        //10
        Quote(title: "Strong minds suffer without complaining; weak minds complain without suffering.", author: "Lettie Cowman"),
        Quote(title: "Strength does not come from physical capacity, it comes from indomitable will.", author: "Mahatma Gandhi"),
        Quote(title: "The energy of the mind is the essence of life.", author: "Aristotle"),
        Quote(title: "The mind is everything. What you think, you become.", author: "Buddha"),
        Quote(title: "To live is the rarest thing in the world. Most people just exist.", author: "Oscar Wilde"),
        Quote(title: "You can’t be brave if you’ve only had wonderful things happen to you.", author: "Mary Tyler Moore"),
        Quote(title: "Rock bottom became the solid foundation on which I rebuilt my life.", author: "J.K. Rowling"),
        Quote(title: "Trust the wait. Embrace the uncertainty. Enjoy the beauty of becoming. When nothing is certain, anything is possible. ", author: "Mandy Hale"),
        Quote(title: "The flower doesn’t dream of the bee. It blossoms and the bee comes.", author: " Mark Nepo"),
        Quote(title: "Happiness does not depend on what you have or who you are. It solely relies on what you think.", author: "Buddha"),
        //20
        Quote(title: "Two things define you. Your patience when you have nothing & your attitude when you have everything.", author: "Unknown"),
        Quote(title: "You are the sky. Everything else—it’s just the weather.", author: "Pema Chodron"),
        Quote(title: "As long as the ego runs your life, there are two ways of being unhappy. Not getting what you want. Getting what you want.", author: "Eckhart Tolle"),
        Quote(title: "Our bravest and best lessons are not learned through success, but through misadventure.", author: "Amos Bronson Alcott"),
        Quote(title: "The lure of the distant and the difficult is deceptive. The great opportunity is where you are.", author: "John Burroughs"),
        Quote(title: "Many things grow in the garden that were never sown there. ", author: "Thomas Fuller"),
        Quote(title: "Start by doing what’s necessary; then do what’s possible; and suddenly you are doing the impossible.", author: "St. Francis of Assisi"),
        Quote(title: "Though we travel the world over to find the beautiful we must carry it with us, or we find it not.", author: "R.W. Emerson"),
        Quote(title: "Vulnerability sounds like truth and looks like courage.", author: "Brene Brown"),
        Quote(title: "Life does not owe you anything because life has already given you everything.", author: "Ralph Marston"),
        //30
        Quote(title: "Courage doesn’t happen when you have all the answers. It happens when you are ready to face the questions you have been avoiding your whole life.", author: "Shannon L. Alder"),
        Quote(title: "The most important questions in life can never be answered by anyone except oneself.", author: "John Fowles, The Magus")
        
        
    ]
}

struct Quote: Identifiable {
    var id = UUID()
    var title = ""
    var author = ""
    
}
/*

     
    
     
     
   
     
 
 */
