//
//  GitHubEventCellViewModel.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/14.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import UIKit

enum GitHubEventType: String {
  case fork = "ForkEvent"
  case member = "MemberEvent"
  case create = "CreateEvent"
  case watch = "WatchEvent"
  case unknown = "UnknownEvent"
}

struct GitHubEventCellViewModel {
  private let event: Event
  private let eventType: GitHubEventType
  
  init(event: Event) {
    self.event = event
    self.eventType = GitHubEventType(rawValue: event.type) ?? .unknown
  }
  
  var typeIconImage: UIImage? {
    switch eventType {
    case .fork:
      return #imageLiteral(resourceName: "fork")
    case .member:
      return #imageLiteral(resourceName: "member")
    case .watch:
      return #imageLiteral(resourceName: "star")
    case .create:
      return #imageLiteral(resourceName: "repository")
    case .unknown:
      return nil
    }
  }
  
  var avatorURL: URL? {
    return URL(string: event.actor.avatar_url)
  }
  
  var time: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    dateFormatter.timeZone = TimeZone(identifier: "Asia/Shanghai")
    guard let date = dateFormatter.date(from: event.created_at) else {
      return ""
    }
    let time = Date().timeIntervalSince(date)
    let days = Int(time / 24 / 60 / 60)
    if days == 0 {
      return "today"
    } else {
      return "\(days) days ago"
    }
  }
  
  var description: NSAttributedString {
    switch eventType {
    case .fork:
      return forkDescription
    case .member:
      return memberDescription
    case .watch:
      return watchDecription
    case .create:
      return createDescription
    case .unknown:
      return NSAttributedString(string: "")
    }
  }
  
  private static let foregroundColor = UIColor(red: 58/255.0, green: 146/255.0, blue: 174/255.0, alpha: 1.0)
  private let highlightStringAttributes = [
    NSAttributedStringKey.foregroundColor: GitHubEventCellViewModel.foregroundColor
  ]
  
  private var forkDescription: NSAttributedString {
    let description = NSMutableAttributedString(attributedString: NSAttributedString(string: event.actor.login, attributes: highlightStringAttributes))
    description.append(NSAttributedString(string: " forked "))
    description.append(NSAttributedString(string: event.repo.name, attributes: highlightStringAttributes))
    description.append(NSAttributedString(string: " to "))
    description.append(NSAttributedString(string: event.payload.forkee?.full_name ?? "", attributes: highlightStringAttributes))
    return description
  }
  
  private var memberDescription: NSAttributedString {
    let description = NSMutableAttributedString(attributedString: NSAttributedString(string: event.actor.login, attributes: highlightStringAttributes))
    description.append(NSAttributedString(string: " "))
    description.append(NSAttributedString(string: event.payload.action ?? "", attributes: highlightStringAttributes))
    description.append(NSAttributedString(string: " "))
    description.append(NSAttributedString(string: event.payload.member?.login ?? "", attributes: highlightStringAttributes))
    description.append(NSAttributedString(string: " as a collaborator to "))
    description.append(NSAttributedString(string: event.repo.name, attributes: highlightStringAttributes))
    return description
  }

  private var createDescription: NSAttributedString {
    let description = NSMutableAttributedString(attributedString: NSAttributedString(string: event.actor.login, attributes: highlightStringAttributes))
    description.append(NSAttributedString(string: " created "))
    description.append(NSAttributedString(string: event.payload.ref_type ?? "", attributes: highlightStringAttributes))
    description.append(NSAttributedString(string: " "))
    description.append(NSAttributedString(string: event.repo.name, attributes: highlightStringAttributes))
    return description
  }

  private var watchDecription: NSAttributedString {
    let description = NSMutableAttributedString(attributedString: NSAttributedString(string: event.actor.login, attributes: highlightStringAttributes))
    description.append(NSAttributedString(string: " "))
    description.append(NSAttributedString(string: event.payload.action ?? ""))
    description.append(NSAttributedString(string: " "))
    description.append(NSAttributedString(string: event.repo.name, attributes: highlightStringAttributes))
    return description
  }
}
