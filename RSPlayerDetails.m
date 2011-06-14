//
//  RSPlayerDetails.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-11.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSPlayerDetails.h"
#import "RSRankMetadataRequest.h"
#import "RSPlaylistMetadataRequest.h"


@implementation RSPlayerDetails
@synthesize AIStats, currentSeasonStats, statsByMap, statsByPlaylist;
@synthesize campaignAggregate,firefightAggregate,campaignAggregateByMap,firefightAggregateByMap,invasionStats,competitiveStats,arenaStats,customGameStats;
@synthesize matchmakingKills,matchmakingDeaths,matchmakingAssists,matchmakingBetrayals,matchmakingMedals,matchmakingGamesPlayed,matchmakingGamesWon,matchmakingPlaytime;
@synthesize lowResPlayerModelURL, highResPlayerModelURL;
@synthesize rankIndex, rankString, rankCredits, credits, creditsToNextRank;

/**
 * Initialize with API Data
 */
- (id)initWithAPIData:(NSDictionary *)data {
	
	if ( (self = [super initWithAPIData:[data objectForKey:@"Player"]]) ) {
		
		// aiStats
		self.AIStats = nil;
		if ( [[data objectForKey:@"AiStatistics"] isKindOfClass:[NSMutableArray class]] ) {
			NSArray *aiStatsResponse = [data objectForKey:@"AiStatistics"];
			NSMutableDictionary *ca_temp = [NSMutableDictionary dictionaryWithCapacity:4];
			NSMutableDictionary *fa_temp = [NSMutableDictionary dictionaryWithCapacity:4];
			NSMutableArray *ai_temp = [NSMutableArray arrayWithCapacity:[aiStatsResponse count]];
			for ( NSDictionary *stats in aiStatsResponse ) {
				RSGroupedAIStats *aiStats = [[[RSGroupedAIStats alloc] initWithAPIData:stats] autorelease];
				if ( aiStats.variantID == 4 && aiStats.difficulty == 255 ) {
					if ( aiStats.mapID == -1 ) {
						self.campaignAggregate = aiStats;
					} else {
						[ca_temp setObject:aiStats forKey:[NSNumber numberWithInt:aiStats.mapID]];
					}
				} else if ( aiStats.variantID == 5 && aiStats.difficulty == 255 ) {
					if ( aiStats.mapID == -1 ) {
						self.firefightAggregate = aiStats;
					} else if ( aiStats.mapID > 0 ) {
						[fa_temp setObject:aiStats forKey:[NSNumber numberWithInt:aiStats.mapID]];
					}
				} else {
					[ai_temp addObject:aiStats];
				}
			}
			self.campaignAggregateByMap = ca_temp;
			self.firefightAggregateByMap = fa_temp;
			self.AIStats = ai_temp;
		}
		
		// Current Season Stats
		self.currentSeasonStats = nil;
		if ( [[data objectForKey:@"CurrentSeasonArenaStatistics"] isKindOfClass:[NSMutableArray class]] ) {
			NSArray *css = [data objectForKey:@"CurrentSeasonArenaStatistics"];
			NSMutableDictionary *css_dict = [NSMutableDictionary dictionaryWithCapacity:[css count]];
			for ( NSDictionary *data in css ) {
				RSSeasonStats *stats = [[[RSSeasonStats alloc] initWithAPIData:data] autorelease];
				NSNumber *key = [NSNumber numberWithInt:stats.seasonID];
				[css_dict setObject:stats forKey:key];
			}
			self.currentSeasonStats = css_dict;
		}
		
		// Stats By Map
		if ( [[data objectForKey:@"StatisticsByMap"] isKindOfClass:[NSMutableArray class]] ) {
			NSArray *sbp = [data objectForKey:@"StatisticsByMap"];
			NSMutableArray *sbm_temp = [NSMutableArray array];
			for ( NSDictionary *stats in sbp ) {
				RSGroupedStats *statsObj = [[[RSGroupedStats alloc] initWithAPIData:stats] autorelease];
				if ( statsObj.mapID == -1 ) {
					if ( statsObj.variantID >= 1 && statsObj.variantID <= 3 ) {
						self.matchmakingKills		+= statsObj.kills;
						self.matchmakingDeaths		+= statsObj.deaths;
						self.matchmakingAssists		+= statsObj.assists;
						self.matchmakingBetrayals	+= statsObj.betrayals;
						self.matchmakingMedals		+= statsObj.totalMedals;
						self.matchmakingGamesPlayed += statsObj.gameCount;
						self.matchmakingGamesWon	+= statsObj.wins;
						self.matchmakingPlaytime	+= statsObj.playtime;
					}
					switch (statsObj.variantID) {
						case 1:
							self.invasionStats = statsObj;
							break;
						case 2:
							self.arenaStats = statsObj;
							break;
						case 3:
							self.competitiveStats = statsObj;
							break;
						case 6:
							self.customGameStats = statsObj;
							break;
					}
				} else {
					[sbm_temp addObject:statsObj];
				}
			}
			self.statsByMap = sbm_temp;
		}
		
		// Stats By Playlist
		if ( [[data objectForKey:@"StatisticsByPlaylist"] isKindOfClass:[NSMutableArray class]] ) {
			
			NSArray *sBP = [data objectForKey:@"StatisticsByPlaylist"];
			NSMutableDictionary *sBP_temp = [NSMutableDictionary dictionary];
			RSPlaylistMetadata *playlistMetadata = [RSPlaylistMetadataRequest get];
			for ( NSDictionary *stats in sBP ) {
				
				// Playlist stats
				RSPlaylistStats *pStats = [[[RSPlaylistStats alloc] initWithAPIData:stats] autorelease];
				[pStats setPlaylistInfo:[playlistMetadata playlistWithID:pStats.hopperID]];
				
				// Add stats
				NSNumber *key = [NSNumber numberWithInt:pStats.variantID];
				if ([sBP_temp objectForKey:key])
					[(RSVariantPlaylistsStats*)[sBP_temp objectForKey:key] addPlaylist:pStats];
				else {
					RSVariantPlaylistsStats *variantPlaylistStats = [[[RSVariantPlaylistsStats alloc] initWithPlaylist:pStats] autorelease];
					[sBP_temp setObject:variantPlaylistStats
								 forKey:key];
				}
			}
			
			self.statsByPlaylist = sBP_temp;
		}
		
		// Player Rank
		if ( [[data objectForKey:@"CurrentRankIndex"] isKindOfClass:[NSString class]] ) {
			self.rankIndex = [data objectForKey:@"CurrentRankIndex"];
		} else if ( [[data objectForKey:@"CurrentRankIndex"] isKindOfClass:[NSNumber class]] ) {
			self.rankIndex = [[data objectForKey:@"CurrentRankIndex"] stringValue];
		} else {
			self.rankIndex = @"0";
		}
		
		// Player Model
		self.lowResPlayerModelURL = [data objectForKey:@"PlayerModelUrl"] ? [@"http://www.bungie.net/" stringByAppendingString:[data objectForKey:@"PlayerModelUrl"]] : nil;
		self.highResPlayerModelURL = [data objectForKey:@"PlayerModelUrlHiRes"] ? [@"http://www.bungie.net/" stringByAppendingString:[data objectForKey:@"PlayerModelUrlHiRes"]] : nil;
        
        self.creditsToNextRank = NSUIntegerMax;
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( (self = [super initWithCoder:aDecoder]) ) {
		self.AIStats = [aDecoder decodeObjectForKey:@"AIS"];
		self.campaignAggregate = [aDecoder decodeObjectForKey:@"cA"];
		self.firefightAggregate = [aDecoder decodeObjectForKey:@"fA"];
		self.campaignAggregateByMap = [aDecoder decodeObjectForKey:@"cABM"];
		self.firefightAggregateByMap = [aDecoder decodeObjectForKey:@"fABM"];
		self.statsByMap = [aDecoder decodeObjectForKey:@"SBM"];
		self.invasionStats = [aDecoder decodeObjectForKey:@"iS"];
		self.competitiveStats = [aDecoder decodeObjectForKey:@"cS"];
		self.arenaStats = [aDecoder decodeObjectForKey:@"aS"];
		self.customGameStats = [aDecoder decodeObjectForKey:@"cGS"];
		self.matchmakingKills = [aDecoder decodeIntForKey:@"mK"];
		self.matchmakingDeaths = [aDecoder decodeIntForKey:@"mD"];
		self.matchmakingAssists = [aDecoder decodeIntForKey:@"mA"];
		self.matchmakingBetrayals = [aDecoder decodeIntForKey:@"mB"];
		self.matchmakingMedals = [aDecoder decodeIntForKey:@"mMC"];
		self.matchmakingGamesPlayed = [aDecoder decodeIntForKey:@"mGP"];
		self.matchmakingGamesWon = [aDecoder decodeIntForKey:@"mGW"];
		self.matchmakingPlaytime = [aDecoder decodeIntForKey:@"mP"];
		self.currentSeasonStats = [aDecoder decodeObjectForKey:@"SBCS"];
		self.statsByPlaylist = [aDecoder decodeObjectForKey:@"SBP"];
		self.lowResPlayerModelURL = [aDecoder decodeObjectForKey:@"lRPMU"];
		self.highResPlayerModelURL = [aDecoder decodeObjectForKey:@"hRPMU"];
		self.rankIndex = [aDecoder decodeObjectForKey:@"rI"];
		//self.rankString = [aDecoder decodeObjectForKey:@"rS"];
		//self.rankCredits = [aDecoder decodeIntForKey:@"rC"];
		//self.credits = [aDecoder decodeIntForKey:@"cR"];
		//self.creditsToNextRank = [aDecoder decodeIntForKey:@"cTNR"];
        self.creditsToNextRank = NSUIntegerMax;
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:self.AIStats forKey:@"AIS"];
	[aCoder encodeObject:self.campaignAggregate forKey:@"cA"];
	[aCoder encodeObject:self.firefightAggregate forKey:@"fA"];
	[aCoder encodeObject:self.campaignAggregateByMap forKey:@"cABM"];
	[aCoder encodeObject:self.firefightAggregateByMap forKey:@"fABM"];
	[aCoder encodeObject:self.statsByMap forKey:@"SBM"];
	[aCoder encodeObject:self.invasionStats forKey:@"iS"];
	[aCoder encodeObject:self.competitiveStats forKey:@"cS"];
	[aCoder encodeObject:self.arenaStats forKey:@"aS"];
	[aCoder encodeObject:self.customGameStats forKey:@"cGS"];
	[aCoder encodeInt:self.matchmakingKills forKey:@"mK"];
	[aCoder encodeInt:self.matchmakingDeaths forKey:@"mD"];
	[aCoder encodeInt:self.matchmakingAssists forKey:@"mA"];
	[aCoder encodeInt:self.matchmakingBetrayals forKey:@"mB"];
	[aCoder encodeInt:self.matchmakingMedals forKey:@"mMC"];
	[aCoder encodeInt:self.matchmakingGamesPlayed forKey:@"mGP"];
	[aCoder encodeInt:self.matchmakingGamesWon forKey:@"mGW"];
	[aCoder encodeInt:self.matchmakingPlaytime forKey:@"mP"];
	[aCoder encodeObject:self.currentSeasonStats forKey:@"SBCS"];
	[aCoder encodeObject:self.statsByPlaylist forKey:@"SBP"];
	[aCoder encodeObject:self.lowResPlayerModelURL forKey:@"lRPMU"];
	[aCoder encodeObject:self.highResPlayerModelURL forKey:@"hRPMU"];
	[aCoder encodeObject:self.rankIndex forKey:@"rI"];
	//[aCoder encodeObject:self.rankString forKey:@"rS"];
	//[aCoder encodeInt:self.rankCredits forKey:@"rC"];
	//[aCoder encodeInt:self.credits forKey:@"cR"];
	//[aCoder encodeInt:self.creditsToNextRank forKey:@"cTNR"];
	[super encodeWithCoder:aCoder];
}

- (void)dealloc {
	[self.AIStats release];
	[self.currentSeasonStats release];
	[self.statsByMap release];
	[self.statsByPlaylist release];
	[self.campaignAggregateByMap release];
	[self.firefightAggregateByMap release];
	[self.lowResPlayerModelURL release];
	[self.highResPlayerModelURL release];
	[self.rankIndex release];
	[rankString release];
	self.campaignAggregate = nil;
	self.firefightAggregate = nil;
	self.invasionStats = nil;
	self.competitiveStats = nil;
	self.arenaStats = nil;
	self.customGameStats = nil;
	[super dealloc];
}

/**
 * Returns the URL for a icon representing the players current rank
 */
- (NSURL *)rankIcon {
	return [NSURL URLWithString:[NSString stringWithFormat:@"http://www.bungie.net/images/reachStats/grades/med/%@.png",self.rankIndex]];
}

/**
 * Returns the players current rank as a string
 * BEWARE: This request will call a synchronous http request to get the required information.
 * Ensure that you call his method in a thread or similar as it may take a long time to complete.
 */
- (NSString *)rankString {
	if ( !rankString ) {
		NSDictionary *metadata = [RSRankMetadataRequest get];
		if ( metadata ) {
			self.rankString  = [(RSRankMetadata*)[metadata objectForKey:self.rankIndex] name];
			self.rankCredits = [(RSRankMetadata*)[metadata objectForKey:self.rankIndex] credits];
		}
	}
	return rankString;
}

/**
 * Returns the amount of credits required to unlock the player's current rank.
 * BEWARE: This request will call a synchronous http request to get the required information.
 * Ensure that you call his method in a thread or similar as it may take a long time to complete.
 */
- (NSUInteger)rankCredits {
	if ( !rankCredits ) {
		NSDictionary *metadata = [RSRankMetadataRequest get];
		self.rankString  = [(RSRankMetadata*)[metadata objectForKey:self.rankIndex] name];
		self.rankCredits = [(RSRankMetadata*)[metadata objectForKey:self.rankIndex] credits];
	}
	return rankCredits;
}

/**
 * Returns the players current amount of credits toward the next rank
 * BEWARE: This request will call a synchronous http request to get the required information.
 * Ensure that you call his method in a thread or similar as it may take a long time to complete.
 */
- (NSUInteger)credits {
	return (self.creditsLifetime - self.rankCredits);
}

/**
 * Returns the credits required to unlock the next rank.
 * BEWARE: This request will call a synchronous http request to get the required information.
 * Ensure that you call his method in a thread or similar as it may take a long time to complete.
 */
- (NSUInteger)creditsToNextRank {
	if ( creditsToNextRank == NSUIntegerMax && self.gamertag ) {
        creditsToNextRank = 0;
		NSArray *ranks = [RSRankMetadataRequest getAsArray];
        for ( unsigned int i = 0; i < [ranks count]; i++ ) {
            RSRankMetadata *rankMetadata = [ranks objectAtIndex:i];
            if ( [[rankMetadata key] isEqualToString:self.rankIndex] && (i + 1) < [ranks count] ) {
                creditsToNextRank = ([(RSRankMetadata*)[ranks objectAtIndex:(i + 1)] credits] - [rankMetadata credits]);
                break;
            }
        }
	}
	return creditsToNextRank;
}

/**
 * Returns the estimated credits earned by the player.
 * BEWARE: This request will call a synchronous http request to get the required information.
 * Ensure that you call his method in a thread or similar as it may take a long time to complete.
 **/
- (NSUInteger)rankTotalCredits {
	return self.creditsLifetime;
}

/**
 * Returns the estimated credits earned by the player as a formatted string (ex. "12,345,678 cR").
 * BEWARE: This request will call a synchronous http request to get the required information.
 * Ensure that you call his method in a thread or similar as it may take a long time to complete.
 **/
- (NSString *)formattedTotalCredits {
	NSNumberFormatter *frmtr = [[NSNumberFormatter alloc] init];
	[frmtr setGroupingSize:3];
	[frmtr setGroupingSeparator:@","];
	[frmtr setUsesGroupingSeparator:YES];
	NSString *commaString = [frmtr stringFromNumber:[NSNumber numberWithInt:[self rankTotalCredits]]];
	[frmtr release];
	return [commaString stringByAppendingString:@" cR"];
}

/**
 * Returns the players overall spread in matchmaking games
 * WARNING: Player needs map information to populate this field
 */
- (NSUInteger)matchmakingSpread {
	return self.matchmakingKills - self.matchmakingDeaths;
}

/**
 * Returns the players overall kill/death in matchmaking games
 * WARNING: Player needs map information to populate this field
 */
- (float)matchmakingKillDeath {
	return (float)self.matchmakingKills / (float)self.matchmakingDeaths;
}

/**
 * Returns the playlist stats for given variant
 * WARNING: Player needs playlist information to populate this field
 */
- (RSVariantPlaylistsStats*)statsWithVariantID:(NSUInteger)variantID {
	return [self.statsByPlaylist objectForKey:[NSNumber numberWithInt:variantID]];
}

@end
