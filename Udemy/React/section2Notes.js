1.) Youtube Search:
Downwards Dataflow. Only the most parent component should be responsible for fetching data. ()

// index.js 
import YTSearch from 'youtube-api-search';

YTSearch({key: API_KEY, term: 'surfboards'}, function(data) {
    console.log(data)
})

2.) 
import React, { Component }

class App extends Component {
    constructor(props) {
        super(props);

        this.state = { videos: [] }

        YTSearch({ key: API_KEY, term: 'surfboards' }, (videos) => {
            this.setState({ videos })
            // this.setSTate({ videos: videos})
        })
    }

    render() {
        return (
            <div>
                <SearchBar />
            </div>
        )
    }
}

3.) Props
// in video_list.js
import React from 'react'

const VideoList = (props) => {
    return (
        <ul className="col-md-4 list-group">
            {props.videos.length}
        </ul>
    );
};

export default VideoList

// in index.js
import React, { Component } from 'react';
import VideoList from './components/video_list';

render() {
    return (
        <div>
            <SearchBar />
            <VideoList videos={this.state.videos} />
        </div>
    )
}

4.) Building Lists with Map
const VideoList = (props) => {
    const videoItems = props.videos.map((video) => {
        return <VideoListItem video={video} />
    })
    return (
        <ul className="col-md-4 list-group">
            {videoItems}
        </ul>
    );
};

// In Video_list_items
import React from 'react'

const VideoListItem = (props) => {
    return <li>Video</li>;
};

export default VideoListItem

5.) Listing Key Props:
// Just needs a unique piece of information. Create id's. 
To see unique ids from API: Inspector, Network, Select API, Preview.

const VideoList = (props) => {
    const videoItems = props.videos.map((video) => {
        return <VideoListItem key={video.etag} video={video} />


    return (
        <ul className="col-md-4 list-group">
            {videoItems}
        </ul>
    );
};

export default VideoList

6.) Video List Items:
/*const VideoListItem = ({ video }) => {
    const imageUrl = video.snippet.thumbnails.default.url
    return (
        <li className="list-group-item">
            <div className="video-list media">
                <div className="media-left">
                    <img className="media-object" src={imageUrl} />
                </div>
                <div className="media-body">
                    <div className="media-heading">{video.snippet.title}</div>
                </div>
            </div>

        </li>
    )
};
*/

7.) Video Detail: //Create file video_detail.js
/*

import React from 'react';

const VideoDetail = ({video}) => {
    if (!video) {
        return <div>Loading...</div>
    }
    const videoId = video.id.videoId
    const url = `https://www.youtube.com/embed/${videoId}`
    return (
        <div className="video-detail col-md-8">
            <div className="embed-responsive embed-responsive-16by9">
                <iframe className="embed-responsibe-item" src={url}></iframe>
            </div>
            <div className="details">
                <div>{video.snippet.title}</div>
                <div>{video.snippet.description}</div>
            </div>
        </div>


    );
};

export default VideoDetail
*/

8.) Handling Null Prompts

In index.js:

/*
import VideoDetail from './components/video_detail';


render() {
        return (
            <div>
                <SearchBar />
                <VideoDetail video={this.state.videos[0]}/>
                <VideoList videos={this.state.videos}/>
            </div>
        )
    }

*/

9.) Video Selection:
class App extends Component {
    constructor(props) {
        super(props);

        this.state = {
            videos: [],
            selectedVideo: null
        }

        YTSearch({ key: API_KEY, term: 'surfboards' }, (videos) => {
            this.setState({
                videos: videos,
                selectedVideo: videos[0]
            })
        })
    }

10.) CSS Styling: //

11.) Search: 
// in index.js
    videoSearch(term) {
        YTSearch({ key: API_KEY, term: term }, (videos) => {
            this.setState({
                videos: videos,
                selectedVideo: videos[0]
            });
        });
    }

    render() {
        return (
            <div>
                <SearchBar onSearchTermChange={term => this.videoSearch(term)} />
            </div>
        )}
// in search_bar.js
    render() {
        return (
            <div className="search-bar">
                <input
                    value={this.state.term}
                    onChange={event => this.onInputChange(event.target.value)} />
            </div>
        );
    }

    onInputChange(term) {
        this.setState({ term });
        this.props.onSearchTermChange(term)
    }

12.) throttling search query: 
Install Lodash
npm install --save lodash
// at the top of index.js:
import _ from 'lodash';

    render() {
        const videoSearch = _.debounce((term) => { this.videoSearch(term) }, 500);