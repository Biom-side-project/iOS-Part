//
//  MainComments.swift
//  Biom
//
//  Created by 오예진 on 2022/08/15.
//

import Foundation

struct MainComments {
    let nickName: String
    let time: Int
    let contents: String
    let heart: Int
}

extension MainComments {
    static let list: [MainComments] = [
        MainComments(nickName: "비 그만와라", time: 6, contents: "갑자기 소나기가 내려서 너무 놀랐어요 ㅠㅠ", heart: 2),
        MainComments(nickName: "비 그만왔으면 좋겠다", time: 15, contents: "비 그만왔으면 좋겠어요", heart: 3),
        MainComments(nickName: "난 비오는거 좋아", time: 29, contents: "나만 비오는거 좋아?", heart: 1)
    ]
}
